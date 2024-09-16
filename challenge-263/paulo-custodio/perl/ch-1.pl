#!/usr/bin/env perl

# Challenge 263
#
# Task 1: Target Index
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints and a target element $k.
#
# Write a script to return the list of indices in the sorted array where the
# element is same as the given target element.
# Example 1
#
# Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
# Output: (1, 2)
#
# Sorted array: (1, 2, 2, 3, 4, 5)
# Target indices: (1, 2) as $ints[1] = 2 and $ints[2] = 2
#
# Example 2
#
# Input: @ints = (1, 2, 4, 3, 5), $k = 6
# Output: ()
#
# No element in the given array matching the given target.
#
# Example 3
#
# Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
# Output: (4)
#
# Sorted array: (1, 2, 2, 3, 4, 5)
# Target index: (4) as $ints[4] = 4

use Modern::Perl;

my($k, @ints) = @ARGV;
@ints = sort {$a <=> $b} @ints;
my @idx =
        map {$_->[0]}
        grep {$_->[1] == $k}
        map {[$_, $ints[$_]]} 0 .. $#ints;
say @idx ? "@idx" : "()";
