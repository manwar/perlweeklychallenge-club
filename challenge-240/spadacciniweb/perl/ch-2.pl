#!/usr/bin/env perl

# Task 2: Build Array
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to create an array such that new[i] = old[old[i]] where 0 <= i < new.length.
#
# Example 1
# 
# Input: @int = (0, 2, 1, 5, 3, 4)
# Output: (0, 1, 2, 4, 5, 3)
# 
# Example 2
# Input: @int = (5, 0, 1, 2, 3, 4)
# Output: (4, 5, 0, 1, 2, 3)

use strict;
use warnings;

my @arrs = ([0, 2, 1, 5, 3, 4],
            [5, 0, 1, 2, 3, 4]
           );

foreach my $arr (@arrs) {
    foreach my $e (@$arr) {
        if ($e >= scalar @$arr) {
            print "Element too big\n";
            exit 1;
        }
    }
    printf "(%s) -> Output: (%s)\n",
        (join ', ', @$arr),
        (join ', ', map { $arr->[$_] } @$arr)
}
