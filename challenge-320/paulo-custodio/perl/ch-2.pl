#!/usr/bin/env perl

# Challenge 320
#
# Task 2: Sum Difference
# Submitted by: Mohammad Sajid Anwar
# You are given an array of positive integers.
#
# Write a script to return the absolute difference between digit sum and element sum of the given array.
#
#
# Example 1
# Input: @ints = (1, 23, 4, 5)
# Output: 18
#
# Element sum: 1 + 23 + 4 + 5 => 33
# Digit sum: 1 + 2 + 3 + 4 + 5 => 15
# Absolute difference: | 33 - 15 | => 18
#
# Example 2
# Input: @ints = (1, 2, 3, 4, 5)
# Output: 0
#
# Element sum: 1 + 2 + 3 + 4 + 5 => 15
# Digit sum: 1 + 2 + 3 + 4 + 5 => 15
# Absolute difference: | 15 - 15 | => 0
#
# Example 3
# Input: @ints = (1, 2, 34)
# Output: 27
#
# Element sum: 1 + 2 + 34 => 37
# Digit sum: 1 + 2 + 3 + 4 => 10
# Absolute difference: | 37 - 10 | => 27

use Modern::Perl;
use List::Util qw(sum);

@ARGV or die "usage: $0 nums...\n";
my @nums = @ARGV;
my @digits = split //, join '', @nums;
say abs(sum(@nums) - sum(@digits));
