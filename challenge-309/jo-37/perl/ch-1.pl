#!/usr/bin/perl

use v5.26;
use Test2::V0 '!float';
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
    $0 - Find minimum gap

    usage: $0 [-examples] [-tests] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of integers in increasing order

    EOS
}


### Input and Output

say min_gap(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/02/21/ch-309.html#task-1

sub min_gap {
    my $ints = long \@_;
    $ints(($ints(1:-1) - $ints(0:-2))->minimum_ind + 1;-);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = min_gap(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[2, 8, 10, 11, 15], 11, 'example 1'],
            [[1, 5, 6, 7, 14], 6, 'example 2'],
            [[8, 20, 25, 28], 28, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is min_gap(1, 2, 4, 4, 7), 4, 'zero gap before four';
    }) : pass 'skip tests';

    exit;
}
