#!/usr/bin/env perl

# Challenge 269
#
# Task 1: Bitwise OR
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of positive integers, @ints.
#
# Write a script to find out if it is possible to select two or more elements
# of the given array such that the bitwise OR of the selected elements has at
# lest one trailing zero in its binary representation.
# Example 1
#
# Input: @ints = (1, 2, 3, 4, 5)
# Output: true
#
# Say, we pick 2 and 4, thier bitwise OR is 6. The binary representation of 6 is 110.
# Return true since we have one trailing zero.
#
# Example 2
#
# Input: @ints = (2, 3, 8, 16)
# Output: true
#
# Say, we pick 2 and 8, thier bitwise OR is 10. The binary representation of 10 is 1010.
# Return true since we have one trailing zero.
#
# Example 3
#
# Input: @ints = (1, 2, 5, 7, 9)
# Output: false

use Modern::Perl;

say trailing_zero(@ARGV) ? 'true' : 'false';

sub trailing_zero {
    my(@ints) = @_;
    my $count_trailing_zero = grep {($_ & 1) == 0} @ints;
    return $count_trailing_zero >= 2;
}
