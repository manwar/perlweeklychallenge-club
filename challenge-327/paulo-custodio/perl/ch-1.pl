#!/usr/bin/env perl

# Challenge 327
#
# Task 1: Missing Integers
# Submitted by: Mohammad Sajid Anwar
# You are given an array of n integers.
#
# Write a script to find all the missing integers in the range 1..n in the given array.
#
#
# Example 1
# Input: @ints = (1, 2, 1, 3, 2, 5)
# Output: (4, 6)
#
# The given array has 6 elements.
# So we are looking for integers in the range 1..6 in the given array.
# The missing integers: (4, 6)
#
# Example 2
# Input: @ints = (1, 1, 1)
# Output: (2, 3)
#
# Example 3
# Input: @ints = (2, 2, 1)
# Output: (3)

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
my @nums = @ARGV;
my %nums; $nums{$_}=1 for @nums;
my @missing = grep {!$nums{$_}} 1 .. @nums;
say join ", ", @missing;
