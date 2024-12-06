#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::MoreUtils 'nsort_by';
use POSIX 'Inf';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [INT...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

INT...
    list of intervals in the form '[S, E]'

EOS


### Input and Output

say "(@{right_interval(map [/^\[(\d+),\s*(\d+)\]$/], @ARGV)})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/12/06/ch-298.html#task-2


sub right_interval (@ints) {
    my @left  = nsort_by {$ints[$_][1]} 0 .. $#ints;
    push @ints, [Inf];
    my @right = nsort_by {$ints[$_][0]} -1 .. $#ints - 1;

    my @result;
    my $r = shift @right;
    for my $l (@left) {
        $r = shift @right while $ints[$r][0] < $ints[$l][1];
        $result[$l] = $r;
    }

    \@result;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is right_interval([3,4], [2,3], [1,2]), [-1, 0, 1], 'example 1';
        is right_interval([1,4], [2,3], [3,4]), [-1, 2, -1], 'example 2';
        is right_interval([1, 2]), [-1], 'example 3';
        is right_interval([1,4], [2, 2], [3, 4]), [-1, 1, -1], 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is right_interval([4, 5], [3, 4], [2, 3], [1, 2]), [-1, 0, 1, 2],
            'backwards';
        is right_interval(map [$_, $_ + 10], 1 .. 20),
            [10 .. 19, (-1) x 10], 'stairs';

        is right_interval([1, 1], [2, 3]), [0, -1], 'first start matches';
        is right_interval([1, 3], [2, 3], [3, 3]), [2, 2, 2], 'non-unique ends';
        is right_interval([4, 4], [2, 3], [1, 2]), [0, 0, 1], 'match all';
    }

    done_testing;
    exit;
}
