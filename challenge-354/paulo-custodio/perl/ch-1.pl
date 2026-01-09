#!/usr/bin/env perl

# Challenge 354
#
# Task 1: Min Abs Diff
# Submitted by: Mohammad Sajid Anwar
# You are given an array of distinct integers.
#
# Write a script to find all pairs of elements with the minimum absolute difference.
#
# Rules (a,b):
# 1: a, b are from the given array.
# 2: a < b
# 3: b - a = min abs diff any two elements in the given array
# Example 1
# Input: @ints= (4, 2, 1, 3)
# Output: [1, 2], [2, 3], [3, 4]
#
# Example 2
# Input: @ints = (10, 100, 20, 30)
# Output: [10, 20], [20, 30]
#
# Example 3
# Input: @ints = (-5, -2, 0, 3)
# Output: [-2, 0]
#
# Example 4
# Input: @ints = (8, 1, 15, 3)
# Output: [1, 3]
#
# Example 5
# Input: @ints = (12, 5, 9, 1, 15)
# Output: [9, 12], [12, 15]

use strict;
use warnings;

@ARGV>=2 or die "Usage: $0 nums...\n";
my @pairs = min_diff(@ARGV);
print join(", ", map {"[".$_->[0].", ".$_->[1]."]"} @pairs), "\n";

sub min_diff {
    my(@nums) = @_;
    return if @nums < 2;
    @nums = sort {$a <=> $b} @nums;

    # compute minimum difference
    my $min_diff = 1e10;
    for my $i (0 .. $#nums-1) {
        for my $j ($i+1 .. $#nums) {
            my $diff = $nums[$j] - $nums[$i];   # numbers are sorted above
            if ($min_diff > $diff) {
                $min_diff = $diff;
            }
        }
    }

    # collect pairs
    my @pairs;
    for my $i (0 .. $#nums-1) {
        for my $j ($i+1 .. $#nums) {
            my $diff = $nums[$j] - $nums[$i];   # numbers are sorted above
            if ($diff == $min_diff) {
                push @pairs, [$nums[$i], $nums[$j]];
            }
        }
    }
    return @pairs;
}
