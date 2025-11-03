#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-345/#TASK1
#
# Task 1: Peak Positions
# ======================
#
# You are given an array of integers, @ints.
#
# Find all the peaks in the array, a peak is an element that is strictly
# greater than its left and right neighbours. Return the indices of all such
# peak positions.
#
## Example 1
##
## Input: @ints = (1, 3, 2)
## Output: (1)
#
#
## Example 2
##
## Input: @ints = (2, 4, 6, 5, 3)
## Output: (2)
#
#
## Example 3
##
## Input: @ints = (1, 2, 3, 2, 4, 1)
## Output: (2, 4)
#
#
## Example 4
##
## Input: @ints = (5, 3, 1)
## Output: (0)
#
#
## Example 5
##
## Input: @ints = (1, 5, 1, 5, 1, 5, 1)
## Output: (1, 3, 5)
#
############################################################
##
## discussion
##
############################################################
#
# We walk from the beginning of the array to the end and check
# if the current element is greater than its neighbors. If so,
# we keep its index around to add it to the result.

use v5.36;

peak_positions(1, 3, 2);
peak_positions(2, 4, 6, 5, 3);
peak_positions(1, 2, 3, 2, 4, 1);
peak_positions(5, 3, 1);
peak_positions(1, 5, 1, 5, 1, 5, 1);

sub peak_positions(@ints) {
    say "Input: (" . join(", ", @ints) . ")";
    my @result = ();
    foreach my $i (0..$#ints) {
        my $keep = 1;
        if($i > 0) {
            $keep = 0 if $ints[$i] <= $ints[$i-1];
        }
        if($i < $#ints) {
            $keep = 0 if $ints[$i] <= $ints[$i+1];
        }
        push @result, $i if $keep;
    }
    say "Output: (" . join(", ", @result) . ")";
}
