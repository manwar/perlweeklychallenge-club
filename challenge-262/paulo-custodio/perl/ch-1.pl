#!/usr/bin/env perl

# Challenge 262
#
# Task 1: Max Positive Negative
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints.
#
# Write a script to return the maximum number of either positive or negative
# integers in the given array.
# Example 1
#
# Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
# Output: 4
#
# Count of positive integers: 4
# Count of negative integers: 3
# Maximum of count of positive and negative integers: 4
#
# Example 2
#
# Input: @ints = (-1, -2, -3, 1)
# Output: 3
#
# Count of positive integers: 1
# Count of negative integers: 3
# Maximum of count of positive and negative integers: 3
#
# Example 3
#
# Input: @ints = (1,2)
# Output: 2
#
# Count of positive integers: 2
# Count of negative integers: 0
# Maximum of count of positive and negative integers: 2

use Modern::Perl;
use List::Util 'max';

my @ints = @ARGV;
say max(scalar(grep {$_>0} @ints), scalar(grep {$_<0} @ints));
