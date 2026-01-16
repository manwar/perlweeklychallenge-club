#!/usr/bin/env perl

# Challenge 338
#
# Task 1: Highest Row
# Submitted by: Mohammad Sajid Anwar
# You are given a m x n matrix.
#
# Write a script to find the highest row sum in the given matrix.
#
#
# Example 1
# Input: @matrix = ([4,  4, 4, 4],
#                   [10, 0, 0, 0],
#                   [2,  2, 2, 9])
# Output: 16
#
# Row 1: 4  + 4 + 4 + 4 => 16
# Row 2: 10 + 0 + 0 + 0 => 10
# Row 3: 2  + 2 + 2 + 9 => 15
#
# Example 2
# Input: @matrix = ([1, 5],
#                   [7, 3],
#                   [3, 5])
# Output: 10
#
# Example 3
# Input: @matrix = ([1, 2, 3],
#                   [3, 2, 1])
# Output: 6
#
# Example 4
# Input: @matrix = ([2, 8, 7],
#                   [7, 1, 3],
#                   [1, 9, 5])
# Output: 17
#
# Example 5
# Input: @matrix = ([10, 20,  30],
#                   [5,  5,   5],
#                   [0,  100, 0],
#                   [25, 25,  25])
# Output: 100

use Modern::Perl;
use List::Util qw(max sum);

my @m = parse_input();
say max map {sum @$_} @m;

sub parse_input {
    my @m;
    while (<>) {
        my @r = split ' ', $_;
        push @m, \@r;
    }
    return @m;
}
