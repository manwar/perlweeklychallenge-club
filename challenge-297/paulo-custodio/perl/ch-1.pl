#!/usr/bin/env perl

# Challenge 297
#
# Task 1: Contiguous Array
# Submitted by: Mohammad Sajid Anwar
# You are given an array of binary numbers, @binary.
#
# Write a script to return the maximum length of a contiguous subarray with an equal number of 0 and 1.
#
# Example 1
# Input: @binary = (1, 0)
# Output: 2
#
# (1, 0) is the longest contiguous subarray with an equal number of 0 and 1.
# Example 2
# Input: @binary = (0, 1, 0)
# Output: 2
#
# (1, 0) or (0, 1) is the longest contiguous subarray with an equal number of 0 and 1.
# Example 3
# Input: @binary = (0, 0, 0, 0, 0)
# Output: 0
# Example 4
# Input: @binary = (0, 1, 0, 0, 1, 0)
# Output: 4

use Modern::Perl;
use List::Util qw(min);

@ARGV or die "usage: $0 nums...\n";
say max_len(@ARGV);

sub max_len {
    my(@digits) = @_;
    my @zeros = grep {$_==0} @digits;
    my @ones  = grep {$_==1} @digits;
    return min(scalar(@zeros), scalar(@ones))*2;
}
