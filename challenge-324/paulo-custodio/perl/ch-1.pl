#!/usr/bin/env perl

# Challenge 324
#
# Task 1: 2D Array
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers and two integers $r amd $c.
#
# Write a script to create two dimension array having $r rows and $c columns using the given array.
#
#
# Example 1
# Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
# Output: ([1, 2], [3, 4])
#
# Example 2
# Input: @ints = (1, 2, 3), $r = 1, $c = 3
# Output: ([1, 2, 3])
#
# Example 3
# Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
# Output: ([1], [2], [3], [4])

use Modern::Perl;

my @nums = split ' ', <>;
my($rows, $cols) = split ' ', <>;
my @m;
for my $r (0 .. $rows-1) {
    $m[$r] = [];
    for my $c (0 .. $cols-1) {
        $m[$r][$c] = shift @nums;
    }
}
say join ", ", map {"[$_]"} map {join ", ", @$_} @m;
