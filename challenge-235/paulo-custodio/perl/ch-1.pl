#!/usr/bin/env perl

# Challenge 235
#
# Task 1: Remove One
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to find out if removing ONLY one integer makes it strictly
# increasing order.
# Example 1
#
# Input: @ints = (0, 2, 9, 4, 6)
# Output: true
#
# Removing ONLY 9 in the given array makes it strictly increasing order.
#
# Example 2
#
# Input: @ints = (5, 1, 3, 2)
# Output: false
#
# Example 3
#
# Input: @ints = (2, 2, 3)
# Output: true

use Modern::Perl;

my @ints = @ARGV;

say can_make_strict_increasing_order(@ints) ? "true" : "false";

sub can_make_strict_increasing_order {
    my(@ints) = @_;
    return 1 if !@ints;
    for my $i (0..$#ints) {
        return 1 if is_strict_increasing(@ints[0..$i-1], @ints[$i+1..$#ints]);
    }
    return 0;
}

sub is_strict_increasing {
    my(@ints) = @_;
    return 1 if !@ints;
    for my $i (1..$#ints) {
        return 0 if $ints[$i] <= $ints[$i-1];
    }
    return 1;
}
