#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N1 N2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1 N2 ...
    some integer numbers

EOS


### Input and Output

main: {
    local $" = ', ';
    say "(@{[min_subarr(@ARGV)]})";
}


### Implementation

# Inspired by Colin's solution to task 1 from week 180.
#
# The minimum subarray can be detected in a single pass, if the right
# data is recorded.  For each number in the given array this is:
# - the number of occurrences
# - the position of the first occurrence
# - the position of the last occurrence
# We found a new candidate for the shortest subarray having the same
# "degree" as the given whenever the current number's count is larger
# than the current maximum or the count equals the current maximum but
# the subarray is shorter.

sub min_subarr {
	my %stats;
    # Initialize the minimum.
    my $min = {cnt => 0};
    while (my ($i, $n) = each @_) {
        # Initialize $n's slot if necessary and create a shortcut.
        my $s = $stats{$n} //= {};
        # Count occurrences and record the start position.
        $s->{start} = $i unless $s->{cnt}++;
        # Record the (current) end position.
        $s->{end} = $i;
        # Identify a new minimum candidate.
        $min = $s if $s->{cnt} > $min->{cnt} ||
            $s->{cnt} == $min->{cnt} &&
            $s->{end} - $s->{start} < $min->{end} - $min->{start};
    }

    # Return the found minimum subarray.
    @_[$min->{start} .. $min->{end}];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [min_subarr(1, 3, 3, 2)], [3, 3], 'Example 1';
        is [min_subarr(1, 2, 1, 3)], [1, 2, 1], 'Example 2';
        is [min_subarr(1, 3, 2, 1, 2)], [2, 1, 2], 'Example 3';
        is [min_subarr(1, 1, 2, 3, 2)], [1, 1], 'Example 4';
        is [min_subarr(2, 1, 2, 1, 1)], [1, 2, 1, 1], 'Example 5';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [min_subarr(1, 1, 1)], [1, 1, 1], 'Full array';
        is [min_subarr(1, 2, 3, 4, 5, 1)], [1, 2, 3, 4, 5, 1], 'Full array';
        is [min_subarr(1, 2, 3)], [1], 'Single element';
	}

    done_testing;
    exit;
}
