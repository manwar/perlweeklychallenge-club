#!/usr/bin/env perl

# Challenge 304
#
# Task 2: Maximum Average
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints and an integer, $n which is less than or equal to total elements in the given array.
#
# Write a script to find the contiguous subarray whose length is the given integer, $n, and has the maximum average. It should return the average.
#
# Example 1
# Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
# Output: 12.75
#
# Subarray: (12, -5, -6, 50)
# Average: (12 - 5 - 6 + 50) / 4 = 12.75
# Example 2
# Input: @ints = (5), $n = 1
# Output: 5

use Modern::Perl;
use List::Util qw(sum max);

my @nums = split ' ', <>;
my $n = <>;

say max_average($n, @nums);

sub max_average {
    my($n, @nums) = @_;
    my $max = -1e10;
    for my $i (0 .. @nums-$n) {
        my $sum = sum(@nums[$i .. $i+$n-1]);
        $max = max($max, $sum);
    }
    return $max/$n;
}
