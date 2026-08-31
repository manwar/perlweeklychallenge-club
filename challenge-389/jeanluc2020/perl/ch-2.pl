#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-389/#TASK2
#
# Task 2: ZigZag Subarray
# =======================
#
# You are given an array of integers.
#
# Write a script to find the length of the longest contiguous subarray where
# the numbers alternate between strictly increasing and strictly decreasing (a
# ZigZag pattern).
#
##  A sequence of numbers $A = [a0, a1, …, ak]$ with length $k >= 1 is
##  considered a ZigZag sequence if every adjacent pair alternates direction:
#
# a_0 < a_1 > a_2 < a_3 > ...
# OR
# a_0 > a_1 < a_2 > a_3 < ...
#
# NOTE: A single element (length 1) or any two distinct elements (length 2) are
# automatically valid ZigZag sequences. Equal adjacent numbers (e.g., 5, 5)
# break the pattern.
#
## Example 1
##
## Input: @nums = (9, 4, 2, 10, 7, 8, 8, 1, 9)
## Output: 5
##
## ZigZag subarray: (4, 2, 10, 7, 8)
#
## Example 2
##
## Input: @nums = (1, 7, 4, 9, 2, 5)
## Output: 6
##
## ZigZag subarray: (1, 7, 4, 9, 2, 5)
#
## Example 3
##
## Input: @nums = (1, 2, 3, 4, 5)
## Output: 2
##
## ZigZag subarray: (1, 2)
#
## Example 4
##
## Input: @nums = (4, 4, 4)
## Output: 1
#
## Example 5
##
## Input: @nums = (10, 20, 15, 12, 18)
## Output: 3
##
## ZigZag subarray: (10, 20, 15)
#
############################################################
##
## discussion
##
############################################################
#
# We check all possible subarrays. We keep track of the maximum length
# of the zigzag subarrays.

use v5.36;

zigzag_subarray(9, 4, 2, 10, 7, 8, 8, 1, 9);
zigzag_subarray(1, 7, 4, 9, 2, 5);
zigzag_subarray(1, 2, 3, 4, 5);
zigzag_subarray(4, 4, 4);
zigzag_subarray(10, 20, 15, 12, 18);

sub zigzag_subarray(@nums) {
    say "Input: (" . join(", ", @nums) . ")";
    my $max_length = 0;
    foreach my $i (0..$#nums) {
        foreach my $j ($i..$#nums) {
            my $n = is_zigzag_subarray(@nums[$i..$j]);
            $max_length = $n if $n > $max_length;
        }
    }
    say "Output: $max_length";
}

sub is_zigzag_subarray(@array) {
    return 1 if scalar(@array) == 1;
    my $count = 1;
    my $last_one = "X";
    foreach my $i (1..$#array) {
        if($array[$i-1] > $array[$i]) {
            return 0 if $last_one eq ">";
            $count++;
            $last_one = ">";
        } elsif ($array[$i-1] < $array[$i]) {
            return 0 if $last_one eq "<";
            $count++;
            $last_one = "<";
        } else {
            return 0;
        }
    }
    return $count;
}
