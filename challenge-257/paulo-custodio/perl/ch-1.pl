#!/usr/bin/env perl

# Challenge 257
#
# Task 1: Smaller than Current
# Submitted by: Mohammad Sajid Anwar
# You are given a array of integers, @ints.
#
# Write a script to find out how many integers are smaller than current i.e.
# foreach ints[i], count ints[j] < ints[i] where i != j.
#
# Example 1
# Input: @ints = (5, 2, 1, 6)
# Output: (2, 1, 0, 3)
#
# For $ints[0] = 5, there are two integers (2,1) smaller than 5.
# For $ints[1] = 2, there is one integer (1) smaller than 2.
# For $ints[2] = 1, there is none integer smaller than 1.
# For $ints[3] = 6, there are three integers (5,2,1) smaller than 6.
# Example 2
# Input: @ints = (1, 2, 0, 3)
# Output: (1, 2, 0, 3)
# Example 3
# Input: @ints = (0, 1)
# Output: (0, 1)
# Example 4
# Input: @ints = (9, 4, 9, 2)
# Output: (2, 1, 2, 0)

use Modern::Perl;

my(@ints) = @ARGV;
my @smaller;
for my $i (0..$#ints) {
    push @smaller, scalar grep {$ints[$_] < $ints[$i]} 0..$#ints;
}
say "@smaller";
