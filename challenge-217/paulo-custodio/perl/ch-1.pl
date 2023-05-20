#!/usr/bin/env perl

# Challenge 217
#
# Task 1: Sorted Matrix
# Submitted by: Mohammad S Anwar
#
# You are given a n x n matrix where n >= 2.
#
# Write a script to find 3rd smallest element in the sorted matrix.
# Example 1
#
# Input: @matrix = ([3, 1, 2], [5, 2, 4], [0, 1, 3])
# Output: 1
#
# The sorted list of the given matrix: 0, 1, 1, 2, 2, 3, 3, 4, 5.
# The 3rd smallest of the sorted list is 1.
#
# Example 2
#
# Input: @matrix = ([2, 1], [4, 5])
# Output: 4
#
# The sorted list of the given matrix: 1, 2, 4, 5.
# The 3rd smallest of the sorted list is 4.
#
# Example 3
#
# Input: @matrix = ([1, 0, 3], [0, 0, 0], [1, 2, 1])
# Output: 0
#
# The sorted list of the given matrix: 0, 0, 0, 0, 1, 1, 1, 2, 3.
# The 3rd smallest of the sorted list is 0.

use Modern::Perl;

say((sort {$a<=>$b} split ' ', "@ARGV" =~ s/\D/ /gr)[2]);
