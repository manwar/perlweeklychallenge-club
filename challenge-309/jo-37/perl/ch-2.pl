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
    $0 - Minimum difference

    usage: $0 [-examples] [-tests] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of integers

    EOS
}


### Input and Output

say min_diff(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/02/21/ch-309.html#task-2


sub min_diff {
    my $ints = long \@_;
    my $diff = $ints - $ints(*1);
    $diff += zeroes($diff)->setvaltobad(0)->tricpy;

    $diff->abs->min;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = min_diff(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1, 5, 8, 9], 1, 'example 1'],
            [[9, 4, 1, 7], 2, 'example 2'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is min_diff(1, 2, 4, 7, 1), 0, 'zero diff';
    }) : pass 'skip tests';

    exit;
}
