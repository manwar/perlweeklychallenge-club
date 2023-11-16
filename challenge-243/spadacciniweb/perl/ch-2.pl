#!/usr/bin/env perl

# Task 2: Floor Sum
# Submitted by: Mohammad S Anwar
# 
# You are given an array of positive integers (>=1).
# Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j < nums.length. The floor() function returns the integer part of the division.
# 
# Example 1
# Input: @nums = (2, 5, 9)
# Output: 10
# 
# floor(2 / 5) = 0
# floor(2 / 9) = 0
# floor(5 / 9) = 0
# floor(2 / 2) = 1
# floor(5 / 5) = 1
# floor(9 / 9) = 1
# floor(5 / 2) = 2
# floor(9 / 2) = 4
# floor(9 / 5) = 1
# 
# Example 2
# Input: @nums = (7, 7, 7, 7, 7, 7, 7)
# Output: 49

use strict;
use warnings;
use PDL;

die "Input error\n"
    if scalar @ARGV < 1
       or
       (scalar map { $_ and $_ =~ /^\d+$/ ? () : 1 }
                 @ARGV) != 0;

my $m = pdl(@ARGV);
printf "$m -> %d\n", ($m/$m->dummy(0))->floor->sum;
