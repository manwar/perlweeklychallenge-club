#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use JSON ();
use File::Basename ();
use constant EXMP => File::Basename::dirname(__FILE__) . 
    '/../../examples/json/ch-1.json';
use experimental 'signatures';

use List::MoreUtils 'frequency';
use List::Util qw(max pairvalues);


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - longest repeating character

    usage: $0 [-examples] [-tests] [STR K]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    K
        an integer

    EOS
}


### Input and Output

say lrc(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/13/ch-399.html#task-1

sub lrc ($str, $k) {
   my $l = length $str;
   for (my $i = $l; $i; $i--) {
       for my $j (0 .. $l - $i) {
           return $i if $i <= $k + max pairvalues
               frequency split //, substr $str, $j, $i;
       }
   }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [lrc(@$args)];

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
