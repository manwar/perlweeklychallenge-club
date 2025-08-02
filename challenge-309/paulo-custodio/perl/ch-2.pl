#!/bin/env perl

# Challenge 309
#
# Task 2: Min Diff
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints.
#
# Write a script to find the minimum difference between any two elements.
# Example 1
#
# Input: @ints = (1, 5, 8, 9)
# Output: 1
#
# 1, 5 => 5 - 1 => 4
# 1, 8 => 8 - 1 => 7
# 1, 9 => 9 - 1 => 8
# 5, 8 => 8 - 5 => 3
# 5, 9 => 9 - 5 => 4
# 8, 9 => 9 - 8 => 1
#
# Example 2
#
# Input: @ints = (9, 4, 1, 7)
# Output: 2
#
# 9, 4 => 9 - 4 => 5
# 9, 1 => 9 - 1 => 8
# 9, 7 => 9 - 7 => 2
# 4, 1 => 4 - 1 => 3
# 4, 7 => 7 - 4 => 3
# 1, 7 => 7 - 1 => 6

use Modern::Perl;

my @list = @ARGV;
say min_diff(@list);

sub min_diff {
    my(@list) = @_;

    my $min_diff = abs($list[0]-$list[-1]); # any two elements
    for my $i (0 .. $#list-1) {
        for my $j ($i+1 .. $#list) {
            my $diff = abs($list[$i]-$list[$j]);
            $min_diff = $diff if $diff < $min_diff;
        }
    }
    return $min_diff;
}
