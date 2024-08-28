#!/usr/bin/env perl

# Challenge 268
#
# Task 2: Number Game
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints, with even number of elements.
#
# Write a script to create a new array made up of elements of the given array.
# Pick the two smallest integers and add it to new array in decreasing order
# i.e. high to low. Keep doing until the given array is empty.
# Example 1
#
# Input: @ints = (2, 5, 3, 4)
# Output: (3, 2, 5, 4)
#
# Round 1: we picked (2, 3) and push it to the new array (3, 2)
# Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)
#
# Example 2
#
# Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
# Output: (1, 1, 4, 3, 6, 4, 9, 6)
#
# Example 3
#
# Input: @ints = (1, 2, 2, 3)
# Output: (2, 1, 3, 2)

use Modern::Perl;

say join " ", number_game(@ARGV);

sub number_game {
    my(@ints) = @_;
    my @out;
    while (@ints) {
        @ints = sort {$a <=> $b} @ints;
        push @out, $ints[1], $ints[0];
        splice @ints, 0, 2;
    }
    return @out;
}
