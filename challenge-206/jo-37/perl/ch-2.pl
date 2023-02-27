#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV && !(@ARGV % 2);
usage: $0 [-examples] [-tests] [N1 N2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1 N2...
    even sized list of numbers

EOS


### Input and Output

say max_pairsum(@ARGV);


### Implementation

# We are given an even sized list of numbers (N₁,...,N₂ₙ).  The list
# shall be partitioned into pairs.  There is a target function defined
# as the sum over the minimum of all the pairs.  This target function
# shall be maximized, i.e. the task is to find a partitioning into pairs
# where the target is maximal and to provide this maximum value.
#
# For the sake of convenience we assume all numbers being distinct.  We
# partition the list into pairs
# ((P¹₁, P¹₂),...,(Pⁿ₁, Pⁿ₂))
# Neither the order of pairs, nor the order of the paired numbers are
# relevant for the target function.  Thus we can chose an arbitrary pair
# P = (a, b), Q = (c, d) and arrange it such that
# a < b, c < d and a < c
# by exchanging the pairs and/or the numbers within the pairs without
# altering the value of the target function.  The contributions to the
# target function are min(P) = a  and min(Q) = c.
#
# Now suppose b > c, i.e. the two pairs "overlap".
# We build a different pairing where b and c are
# exchanged and all other pairs remain unaltered, i.e.
# P' = (a, c) and Q' = (b, d)
# The new contributions to the target function are
# min(P') = a = min(P) (from the precondition a < c) and
# min(Q') = min(b, d) > min(c, d) = min(Q) (from our assumption b > c
# and the precondition c < d)
# All summands in the target function remain unchanged with the
# exception of Q', which increased from Q.
#
# There is only one partitioning into pairs where none of the pairs
# overlap:  Taking the pairs as adjacent elements from the sorted list.
# From the above considerations, this partitioning maximizes the target
# function.
#
# A long introduction to a short solution:
sub max_pairsum {
    # Sum over the first elements of successive pairs taken from the
    # sorted list.
    sum pdl(@_)->qsort->(0:-2:2);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is max_pairsum(1,2,3,4), 4, 'example 1';
        is max_pairsum(0,2,1,3), 2, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
