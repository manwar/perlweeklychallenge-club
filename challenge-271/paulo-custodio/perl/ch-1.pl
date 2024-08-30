#!/usr/bin/env perl

# Challenge 271
#
# Task 1: Maximum Ones
# Submitted by: Mohammad Sajid Anwar
# You are given a m x n binary matrix.
#
# Write a script to return the row number containing maximum ones, in case of
# more than one rows then return smallest row number.
#
# Example 1
# Input: $matrix = [ [0, 1],
#                    [1, 0],
#                  ]
# Output: 1
#
# Row 1 and Row 2 have the same number of ones, so return row 1.
# Example 2
# Input: $matrix = [ [0, 0, 0],
#                    [1, 0, 1],
#                  ]
# Output: 2
#
# Row 2 has the maximum ones, so return row 2.
# Example 3
# Input: $matrix = [ [0, 0],
#                    [1, 1],
#                    [0, 0],
#                  ]
# Output: 2
#
# Row 2 have the maximum ones, so return row 2.

use Modern::Perl;
use List::Util 'max';

my @matrix = split /,/, "@ARGV";
@matrix = map {[split ' ', $_]} @matrix;

say 1+max_ones(@matrix);

sub max_ones {
    my(@matrix) = @_;
    my @ones = map {tr/1/1/} map {join '', @$_} @matrix;
    my $max = max(@ones);
    for (0 .. $#ones) {
        return $_ if $ones[$_] == $max;
    }
    return 0;
}
