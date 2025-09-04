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
    $0 - smaller than current

    usage: $0 [-examples] [-tests] [--] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of numbers

    EOS
}


### Input and Output

say smaller_than_current(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/09/05/ch-337.html#task-1


sub smaller_than_current {
    my $num = pdl @_;
    my $sort = $num($num->qsorti);
    $sort .= $sort(-1:0)->dummy(0)->enumvec->(-1:0);
    $sort += sequence $num;
    $num;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = smaller_than_current(@$args)->unpdl;
        is $result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[6, 5, 4, 8], [2, 1, 0, 3], 'example 1'],
            [[7, 7, 7, 7], [3, 3, 3, 3], 'example 2'],
            [[5, 4, 3, 2, 1], [4, 3, 2, 1, 0], 'example 3'],
            [[-1, 0, 3, -2, 1], [1, 2, 4, 0, 3], 'example 4'],
            [[0, 1, 1, 2, 0], [1, 3, 3, 4, 1], 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[4,1,3,1,4,1,3,1,3,1], [9,4,7,4,9,4,7,4,7,4], 'repeated values'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
