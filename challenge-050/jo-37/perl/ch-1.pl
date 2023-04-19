#!/usr/bin/perl -s

use v5.24;
use List::Util qw(min max);
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [L,U...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

L,U
    list of intervals given by comma separated lower and upper limit.

EOS


### Input and Output

main: {
    local $" = ',';
    local $, = ',';
    say map "[@$_]", merge_intervals(map [split /,/, $_], @ARGV)->@*;
}


### Implementation

# Regarding the given intervals as closed.  Therefore two intervals of
# the form [a, b] [b, c] are merged into [a, c].
sub merge_intervals {
    my @merged;
    my $prev;
    for my $int (@_) {
        if ($prev && $int->[0] <= $prev->[1]) {
            $prev = [min($prev->[0], $int->[0]), max($prev->[1], $int->[1])];
        } else {
            push @merged, $prev if $prev;
            $prev = $int;
        }
    }
    push @merged, $prev;
    \@merged;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is merge_intervals([2,7], [3,9], [10,12], [15,19], [18,22]),
        [[2, 9], [10, 12], [15, 22]], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        is merge_intervals([1, 4], [5, 8]), [[1, 4], [5, 8]], 'disjoint';
        is merge_intervals([1, 4], [4, 8]), [[1, 8]], 'adjacent';
        is merge_intervals([1, 4], [3, 8]), [[1, 8]], 'overlapping';
        is merge_intervals([1, 8], [2, 6]), [[1, 8]], 'including';
	}

    done_testing;
    exit;
}
