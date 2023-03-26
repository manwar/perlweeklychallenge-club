#!/usr/bin/perl

# Challenge 197
#
# Task 1: Move Zero
# Submitted by: Mohammad S Anwar
# You are given a list of integers, @list.
#
# Write a script to move all zero, if exists, to the end while maintaining
# the relative order of non-zero elements.
#
#
# Example 1
# Input:  @list = (1, 0, 3, 0, 0, 5)
# Output: (1, 3, 5, 0, 0, 0)
# Example 2
# Input: @list = (1, 6, 4)
# Output: (1, 6, 4)
# Example 3
# Input: @list = (0, 1, 0, 2, 0)
# Output: (1, 2, 0, 0, 0)

use Modern::Perl;

say join " ", (grep {$_} @ARGV), (grep {!$_} @ARGV);
