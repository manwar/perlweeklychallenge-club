#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util 'factor_exp';
use List::Util 'sum';


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
    $0 - omega

    usage: $0 [-examples] [-tests] [NUM MODE]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    NUM
        a positive integer

    MODE
        a real number

    EOS
}


### Input and Output

say omega($ARGV[1], $ARGV[0]);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/04/12/ch-368.html#task-2

sub omega {
    my $exp = shift;
    sum map $_->[1] ** $exp, factor_exp(shift);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = omega(@$args);
        is $result, $expected,
            "$name: (@$args) ->  $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[0, 100061], 3, 'example 1'],
            [[0, 971088], 3, 'example 2'],
            [[1, 63640], 6, 'example 3'],
            [[1, 988841], 2, 'example 4'],
            [[0, 211529], 2, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is omega(2, 1944810000), 64, 'exp = 2';
        is omega(-1, 1944810000), 1, 'exp = -1';
        is omega(0.5, 1944810000), 8, 'exp = .5' 
    }) : pass 'skip tests';

    exit;
}
