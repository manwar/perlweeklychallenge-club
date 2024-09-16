#!/usr/bin/env perl

# Challenge 222
#
# Task 1: Matching Members
# Submitted by: Mohammad S Anwar
# You are given a list of positive integers, @ints.
#
# Write a script to find the total matching members after sorting the list
# increasing order.
#
#
# Example 1
# Input: @ints = (1, 1, 4, 2, 1, 3)
# Output: 3
#
# Original list: (1, 1, 4, 2, 1, 2)
# Sorted list  : (1, 1, 1, 2, 3, 4)
#
# Compare the two lists, we found 3 matching members (1, 1, 2).
# Example 2
# Input: @ints = (5, 1, 2, 3, 4)
# Output: 0
#
# Original list: (5, 1, 2, 3, 4)
# Sorted list  : (1, 2, 3, 4, 5)
#
# Compare the two lists, we found 0 matching members.
# Example 3
# Input: @ints = (1, 2, 3, 4, 5)
# Output: 5
#
# Original list: (1, 2, 3, 4, 5)
# Sorted list  : (1, 2, 3, 4, 5)
#
# Compare the two lists, we found 5 matching members.

use Modern::Perl;

my @ints = @ARGV;
say matching_members(@ints);

sub matching_members {
    my(@ints) = @_;

    my @sorted = sort {$a <=> $b} @ints;
    my $matching = scalar grep {$ints[$_]==$sorted[$_]} 0..$#ints;
    return $matching;
}
