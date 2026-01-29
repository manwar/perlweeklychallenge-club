#!/usr/bin/env perl

# Challenge 320
#
# Task 1: Maximum Count
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers.
#
# Write a script to return the maximum between the number of positive and negative integers. Zero is neither positive nor negative.
#
#
# Example 1
# Input: @ints = (-3, -2, -1, 1, 2, 3)
# Output: 3
#
# There are 3 positive integers.
# There are 3 negative integers.
# The maximum between 3 and 3 is 3.
#
# Example 2
# Input: @ints = (-2, -1, 0, 0, 1)
# Output: 2
#
# There are 1 positive integers.
# There are 2 negative integers.
# The maximum between 2 and 1 is 2.
#
# Example 3
# Input: @ints = (1, 2, 3, 4)
# Output: 4
#
# There are 4 positive integers.
# There are 0 negative integers.
# The maximum between 4 and 0 is 4.

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 nums...\n";
my @nums = @ARGV;
my $num_positive = scalar grep {$_>0} @nums;
my $num_negative = scalar grep {$_<0} @nums;
say max($num_negative, $num_positive);

