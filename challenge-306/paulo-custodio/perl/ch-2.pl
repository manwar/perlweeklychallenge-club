#!/usr/bin/env perl

# Challenge 306
#
# Task 2: Last Element
# Submitted by: Mohammad Sajid Anwar
# You are given a array of integers, @ints.
#
# Write a script to play a game where you pick two biggest integers in the given array, say x and y. Then do the following:
#
# a) if x == y then remove both from the given array
# b) if x != y then remove x and replace y with (y - x)
# At the end of the game, there is at most one element left.
#
# Return the last element if found otherwise return 0.
#
# Example 1
# Input: @ints = (3, 8, 5, 2, 9, 2)
# Output: 1
#
# Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
# Step 2: pick 3 and 5 => (2, 2, 1, 2)
# Step 3: pick 2 and 1 => (1, 2, 2)
# Step 4: pick 2 and 1 => (1, 2)
# Step 5: pick 1 and 2 => (1)
# Example 2
# Input: @ints = (3, 2, 5)
# Output: 0
#
# Step 1: pick 3 and 5 => (2, 2)
# Step 2: pick 2 and 2 => ()

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

my @remaining = pick_values(@ARGV);
say @remaining ? $remaining[0] : 0;

sub pick_values {
    my(@nums) = @_;
    while (@nums > 1) {
        @nums = sort {$b <=> $a} @nums;
        my($x, $y) = splice(@nums, 0, 2);
        if ($x != $y) {
            push @nums, $x - $y;
        }
    }
    return @nums;
}
