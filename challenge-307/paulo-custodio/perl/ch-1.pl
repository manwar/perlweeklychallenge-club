#!/usr/bin/env perl

# Challenge 307
#
# Task 1: Check Order
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.
#
# Write a script to re-arrange the given array in an increasing order and return the indices where it differs from the original array.
#
# Example 1
# Input: @ints = (5, 2, 4, 3, 1)
# Output: (0, 2, 3, 4)
#
# Before: (5, 2, 4, 3, 1)
# After : (1, 2, 3, 4, 5)
#
# Difference at indices: (0, 2, 3, 4)
# Example 2
# Input: @ints = (1, 2, 1, 1, 3)
# Output: (1, 3)
#
# Before: (1, 2, 1, 1, 3)
# After : (1, 1, 1, 2, 3)
#
# Difference at indices: (1, 3)
# Example 3
# Input: @ints = (3, 1, 3, 2, 3)
# Output: (0, 1, 3)
#
# Before: (3, 1, 3, 2, 3)
# After : (1, 2, 3, 3, 3)
#
# Difference at indices: (0, 1, 3)

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say join ", ", compare_order(@ARGV);

sub compare_order {
    my(@nums) = @ARGV;
    my @ordered = sort {$a <=> $b} @nums;
    my @indices;
    for (0 .. $#nums) {
        push @indices, $_ if $nums[$_] != $ordered[$_];
    }
    return @indices;
}
