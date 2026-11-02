#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use JSON ();
use File::Basename ();
use constant EXMP => File::Basename::dirname(__FILE__) . 
    '/../../examples/json/ch-2.json';
use experimental 'signatures';

use List::MoreUtils 'slide';
use List::UtilsBy 'partition_by';
use List::Util 'pairvalues';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - string difference

    usage: $0 [-examples] [-tests] [W...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    W...
        list of words

    EOS
}


### Input and Output

say "@{[single_str_diff(@ARGV)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/06/ch-398.html#task-2

sub single_str_diff {
    state sub str_diff {
        join ':', slide {$b - $a} map ord, split //, shift;
    };

    map @$_ == 1 ? @$_ : (), pairvalues partition_by \&str_diff, @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [single_str_diff(@$args)];

        is $result, $expected,
            "$name: (@{fa(@$args)}) -> @{fa(@$expected)}";
    }
    return unless $examples || $tests;

    plan 2;
    my $exmp = do {
        use autodie;
        local $/;
        open my $xfh, '<', EXMP;
        my $ex = JSON->new->utf8->boolean_values(0, 1)->decode(<$xfh>);
        close $xfh;
        $ex; 
    };
    ##\{$exmp}

    $examples ? subtest_streamed($exmp->{challenge}{name} => sub {
        plan scalar $exmp->{examples}->@*;
        run_example $_->{in}, $_->{out}, $_->{name}
            for $exmp->{examples}->@*;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
