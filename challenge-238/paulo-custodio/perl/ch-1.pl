#!/usr/bin/env perl

# Challenge 238
#
# Task 1: Running Sum
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to return the running sum of the given array. The running sum
# can be calculated as sum[i] = num[0] + num[1] + …. + num[i].
# Example 1
#
# Input: @int = (1, 2, 3, 4, 5)
# Output: (1, 3, 6, 10, 15)
#
# Example 2
#
# Input: @int = (1, 1, 1, 1, 1)
# Output: (1, 2, 3, 4, 5)
#
# Example 3
#
# Input: @int = (0, -1, 1, 2)
# Output: (0, -1, 0, 2)

use Modern::Perl;

my @n = @ARGV;
my $sum = 0;
say join " ", map {$sum += $_} @n;
