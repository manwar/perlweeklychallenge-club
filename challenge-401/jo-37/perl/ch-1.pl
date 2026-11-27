#!/usr/bin/perl -T

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use JSON ();
use File::Basename ();
use constant EXMP => File::Basename::dirname(__FILE__) . 
    '/../../examples/json/ch-1.json';
use experimental 'signatures';

use bigrat;


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - fractional addition substraction

    usage: $0 [-examples] [-tests] [--] [EXPR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    EXPR
        a string

    EOS
}


### Input and Output

say frac_add_sub(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/27/ch-401.html#task-1

sub frac_add_sub ($expr) {
    $expr =~ m{^(-?(?:\d+/\d+(?:[-+]|$))+)$} or return;
    my $r = eval $1;
    $r->numerator . '/' . $r->denominator;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [frac_add_sub(@$args)];

        is $result, $expected,
            "$name: (@{fa(@$args)}) -> @{fa(@$expected)}";
    }

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
