#!/usr/bin/env perl

# Challenge 152
#
# TASK #1 › Triangle Sum Path
# Submitted by: Mohammad S Anwar
# You are given a triangle array.
#
# Write a script to find the minimum sum path from top to bottom.
#
# Example 1:
# Input: $triangle = [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]
#
#                 1
#                5 3
#               2 3 4
#              7 1 0 2
#             6 4 5 2 8
#
# Output: 8
#
#     Minimum Sum Path = 1 + 3 + 2 + 0 + 2 => 8
# Example 2:
# Input: $triangle = [ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]
#
#                 5
#                2 3
#               4 1 5
#              0 1 2 3
#             7 2 4 1 9
#
# Output: 9
#
#     Minimum Sum Path = 5 + 2 + 1 + 0 + 1 => 9

use Modern::Perl;
use List::Util qw( sum min );

my @lines = read_lines();
say min_sum_path(@lines);


sub read_lines {
    my @lines;
    while (<>) {
        my @col = split " ", $_;
        push @lines, \@col;
    }
    return @lines;
}

sub min_sum_path {
    my(@lines) = @_;
    my @path = map {min @$_} @lines;
    return sum(@path);
}
