#!/usr/bin/env perl

# Task 1: Reverse Pairs
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to return the number of reverse pairs in the given array.
# 
# A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].
#
# Example 1
# Input: @nums = (1, 3, 2, 3, 1)
# Output: 2
# 
# (1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
# (3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1
# 
# Example 2
# Input: @nums = (2, 4, 3, 5, 1)
# Output: 3
# 
# (1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
# (2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
# (3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1

use strict;
use warnings;
use PDL;


my $m_input = pdl(@ARGV);
my $m = $m_input->dummy(1, scalar @ARGV);
my $m_t = $m->transpose;
printf "$m_input -> %d", (($m->xvals < $m->yvals) & ($m > 2*$m_t))->sum;
