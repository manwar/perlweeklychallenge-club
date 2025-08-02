#!/usr/bin/env perl

# Challenge 290
#
# Task 1: Double Exist
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints.
#
# Write a script to find if there exist two indices $i and $j such that:
#
# 1) $i != $j
# 2) 0 <= ($i, $j) < scalar @ints
# 3) $ints[$i] == 2 * $ints[$j]
#
# Example 1
#
# Input: @ints = (6, 2, 3, 3)
# Output: true
#
# For $i = 0, $j = 2
# $ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]
#
# Example 2
#
# Input: @ints = (3, 1, 4, 13)
# Output: false
#
# Example 3
#
# Input: @ints = (2, 1, 4, 2)
# Output: true
#
# For $i = 2, $j = 3
# $ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]

use Modern::Perl;

sub double_exist {
    my(@n) = @_;
    for my $i (0..$#n-1) {
        for my $j ($i+1..$#n) {
            if ($n[$i]==2*$n[$j] || $n[$j]==2*$n[$i]) {
                return 1;
            }
        }
    }
    return 0;
}

say double_exist(@ARGV) ? "true" : "false";
