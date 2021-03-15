#!/usr/bin/perl

# Challenge 078
#
# TASK #1 › Leader Element
# Submitted by: Mohammad S Anwar
# You are given an array @A containing distinct integers.
#
# Write a script to find all leader elements in the array @A. Print (0) if none found.
#
# An element is leader if it is greater than all the elements to its right side.
#
# Example 1:
# Input: @A = (9, 10, 7, 5, 6, 1)
# Output: (10, 7, 6, 1)
# Example 2:
# Input: @A = (3, 4, 5)
# Output: (5)

use strict;
use warnings;
use 5.030;

my @A = @ARGV;
my $max = 0;
my @leaders;
for my $i (reverse 0..$#A) {
    if ($A[$i] > $max) {
        unshift @leaders, $A[$i];
        $max = $A[$i];
    }
}
@leaders = (0) unless @leaders;
say "(", join(", ", @leaders), ")";
