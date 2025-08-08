#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::LinearAlgebra;


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
    $0 - straight line

    usage: $0 [-examples] [-tests] [P...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    POINTS
        list of points in any form accepted by the PDL string constructor,
        eg. "[2, 1], [2, 3], [2, 5]" or "2,1;2,3;2,5"

    EOS
}


### Input and Output

say +(qw(true false))[!straight_line("@ARGV")];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/08/08/ch-333.html#task-1

sub straight_line {
    mrank(pdl(@_)->append(1)) <= 2;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = straight_line(@$args);
        is $result, $expected,
            "$name: (@{[map qq([@$_]), @$args]}) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[2, 1], [2, 3], [2, 5]], T(), 'example 1'],
            [[[1, 4], [3, 4], [10, 4]], T(), 'example 2'],
            [[[0, 0], [1, 1], [2, 3]], F(), 'example 3'],
            [[[1, 1], [1, 1], [1, 1]], T(), 'example 4'],
            [[[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]],
                T(), 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[[2, 1], [2, 3], [2, 5], [2, 7]], T(), 'four points in line'],
            [[[2, 1], [2, 3], [2, 5], [3, 7]], F(), 'four points'],
            [[[1, 1, 1], [1, 2, 2], [1, 3, 3]], T(), 'in line in three dims'],
            [[[1, 1, 1], [1, 2, 2], [2, 3, 3]], F(), 'three dims'],
            [[[[2, 3, 5, 7]]], T(), 'single point'],
            [[[2, 3, 5, 7], [11, 13, 17, 19]], T(), 'two points'],
            [[[2], [3], [5], [7]], T(), 'points in 1-d'],
            [[[2, 1], [2, 3], [2, 5], [3, 7]], F(), 'four points'],
            [[[3, 0], [0, 9], [2, 3]], T(), 'example from blog'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
