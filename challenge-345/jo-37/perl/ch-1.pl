#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;


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
    $0 - peak positions

    usage: $0 [-examples] [-tests] [--] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of integers

    EOS
}


### Input and Output

say peak_positions(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/31/ch-345.html#task-1

sub peak_positions {
    my $i = pdl -inf, @_, -inf;
    my $s = ($i(1:-1) - $i(0:-2))->mult(1e6)->clip(-1, 1);

    which $s(0:-2) - $s(1:-1) == 2;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = peak_positions(@$args)->unpdl;
        is $result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1, 3, 2], [1], 'example 1'],
            [[2, 4, 6, 5, 3], [2], 'example 2'],
            [[1, 2, 3, 2, 4, 1], [2, 4], 'example 3'],
            [[5, 3, 1], [0], 'example 4'],
            [[1, 5, 1, 5, 1, 5, 1], [1, 3, 5], 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[1, 2, 2, 1], [], 'no peak 1'],
            [[1, 2, 2, 2, 1], [], 'no peak 2'],
            [[2, 1, 1, 2], [0, 3], 'sink'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
