#!/usr/bin/env perl

# Challenge 306
#
# Task 1: Odd Sum
# Submitted by: Mohammad Sajid Anwar
# You are given an array of positive integers, @ints.
#
# Write a script to return the sum of all possible odd-length subarrays of the given array. A subarray is a contiguous subsequence of the array.
#
# Example 1
# Input: @ints = (2, 5, 3, 6, 4)
# Output: 77
#
# Odd length sub-arrays:
# (2) => 2
# (5) => 5
# (3) => 3
# (6) => 6
# (4) => 4
# (2, 5, 3) => 10
# (5, 3, 6) => 14
# (3, 6, 4) => 13
# (2, 5, 3, 6, 4) => 20
#
# Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77
# Example 2
# Input: @ints = (1, 3)
# Output: 4

use Modern::Perl;
use List::Util qw(sum);

@ARGV or die "usage: $0 nums...\n";
say sum_odds(@ARGV);

sub sum_odds {
    my(@nums) = @_;
    my $sum = 0;
    for (my $len = 1; $len <= @nums; $len += 2) {
        for my $i (0 .. $#nums) {
            next if $i + $len > @nums;
            $sum += sum(@nums[$i .. $i + $len - 1]);
        }
    }
    return $sum;
}
