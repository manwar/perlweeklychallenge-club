#!/usr/bin/env perl

# Challenge 343
#
# Task 1: Zero Friend
# Submitted by: Mohammad Sajid Anwar
# You are given a list of numbers.
#
# Find the number that is closest to zero and return its distance to zero.
#
#
# Example 1
# Input: @nums = (4, 2, -1, 3, -2)
# Output: 1
#
# Values closest to 0: -1 and 2 (distance = 1 and 2)
#
# Example 2
# Input: @nums = (-5, 5, -3, 3, -1, 1)
# Output: 1
#
# Values closest to 0: -1 and 1 (distance = 1)
#
# Example 3
# Input: @ums = (7, -3, 0, 2, -8)
# Output: 0
#
# Values closest to 0: 0 (distance = 0)
# Exact zero wins regardless of other close values.
#
# Example 4
# Input: @nums = (-2, -5, -1, -8)
# Output: 1
#
# Values closest to 0: -1 and -2 (distance = 1 and 2)
#
# Example 5
# Input: @nums = (-2, 2, -4, 4, -1, 1)
# Output: 1
#
# Values closest to 0: -1 and 1 (distance = 1)

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say((sort {$a<=>$b} map {abs($_)} @ARGV)[0]);
