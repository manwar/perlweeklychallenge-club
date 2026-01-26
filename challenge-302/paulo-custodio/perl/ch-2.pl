#!/usr/bin/env perl

# Challenge 302
#
# Task 2: Step by Step
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.
#
# Write a script to find the minimum positive start value such that step by step sum is never less than one.
#
# Example 1
# Input: @ints = (-3, 2, -3, 4, 2)
# Output: 5
#
# For start value 5.
# 5 + (-3) = 2
# 2 + (+2) = 4
# 4 + (-3) = 1
# 1 + (+4) = 5
# 5 + (+2) = 7
# Example 2
# Input: @ints = (1, 2)
# Output: 1
# Example 3
# Input: @ints = (1, -2, -3)
# Output: 5

use Modern::Perl;
use List::Util qw(min max);

@ARGV or die "usage: $0 nums...\n";

say min_start_value(@ARGV);

sub min_start_value {
    my(@steps) = @_;
    my $cur = 0;
    my @heights;
    for (@steps) {
        $cur += $_;
        push @heights, $cur;
    }
    my $min_height = min(@heights);
    return max(1, 1 - $min_height);
}
