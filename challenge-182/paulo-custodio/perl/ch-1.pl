#!/usr/bin/env perl

# Challenge 182
#
# Task 1: Max Index
# Submitted by: Mohammad S Anwar
#
# You are given a list of integers.
#
# Write a script to find the index of the first biggest number in the list.
# Example
#
# Input: @n = (5, 2, 9, 1, 7, 6)
# Output: 2 (as 3rd element in the list is the biggest number)
#
#
# Input: @n = (4, 2, 3, 1, 5, 0)
# Output: 4 (as 5th element in the list is the biggest number)

use Modern::Perl;

my @in = @ARGV;
say((map {$_->[0]} sort {$b->[1] <=> $a->[1]} map {[$_, $in[$_]]} 0..$#in)[0]);
