#!/bin/env perl

# Challenge 309
#
# Task 1: Min Gap
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints, increasing order.
#
# Write a script to return the element before which you find the smallest gap.
# Example 1
#
# Input: @ints = (2, 8, 10, 11, 15)
# Output: 11
#
#  8 - 2  => 6
# 10 - 8  => 2
# 11 - 10 => 1
# 15 - 11 => 4
#
# 11 is where we found the min gap.
#
# Example 2
#
# Input: @ints = (1, 5, 6, 7, 14)
# Output: 6
#
#  5 - 1 => 4
#  6 - 5 => 1
#  7 - 6 => 1
# 14 - 7 => 7
#
# 6 and 7 where we found the min gap, so we pick the first instance.
#
# Example 3
#
# Input: @ints = (8, 20, 25, 28)
# Output: 28
#
#  8 - 20 => 14
# 25 - 20 => 5
# 28 - 25 => 3
#
# 28 is where we found the min gap.

use Modern::Perl;

my @list = @ARGV;
my($min_gap, @dummy) =
        map {$_->[0]}
        sort {$a->[1] <=> $b->[1]}
        map {[$list[$_], abs($list[$_]-$list[$_-1])]} 1..$#list;
say $min_gap;
