#!/usr/bin/perl

# Challenge 086

# TASK #1 › Pair Difference
# Submitted by: Mohammad S Anwar
# You are given an array of integers @N and an integer $A.
#
# Write a script to find find if there exists a pair of elements in the array whose difference is $A.
#
# Print 1 if exists otherwise 0.
#
# Example 1:
# Input: @N = (10, 8, 12, 15, 5) and $A = 7
# Output: 1 as 15 - 8 = 7
# Example 2:
# Input: @N = (1, 5, 2, 9, 7) and $A = 6
# Output: 1 as 7 - 1 = 6
# Example 3:
# Input: @N = (10, 30, 20, 50, 40) and $A = 15
# Output: 0

use strict;
use warnings;
use 5.030;

# input: list of numbers, last is the difference
my @N = @ARGV;
my $A = pop @N;

say found($A, @N);

sub found {
    my($a, @n) = @_;
    for my $i (0 .. $#n-1) {
        for my $j ($i+1 .. $#n) {
            if (abs($n[$i]-$n[$j]) == $a) {
                return 1;
            }
        }
    }
    return 0;
}
