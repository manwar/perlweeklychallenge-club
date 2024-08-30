#!/usr/bin/env perl

# Challenge 270
#
# Task 1: Special Positions
# Submitted by: Mohammad Sajid Anwar
# You are given a m x n binary matrix.
#
# Write a script to return the number of special positions in the given binary matrix.
#
# A position (i, j) is called special if $matrix[i][j] == 1 and all other
# elements in the row i and column j are 0.
#
# Example 1
# Input: $matrix = [ [1, 0, 0],
#                    [0, 0, 1],
#                    [1, 0, 0],
#                  ]
# Output: 1
#
# There is only one special position (1, 2) as $matrix[1][2] == 1
# and all other elements in row 1 and column 2 are 0.
# Example 2
# Input: $matrix = [ [1, 0, 0],
#                    [0, 1, 0],
#                    [0, 0, 1],
#                  ]
# Output: 3
#
# Special positions are (0,0), (1, 1) and (2,2).

use Modern::Perl;

my @matrix = split /,/, "@ARGV";
@matrix = map {[split ' ', $_]} @matrix;

say count_special_pos(@matrix);

sub count_special_pos {
    my(@matrix) = @_;
    my $special = 0;
    for my $i (0 .. $#matrix) {
        for my $j (0 .. $#{$matrix[0]}) {
            $special++ if is_special_pos($i, $j, @matrix);
        }
    }
    return $special;
}

sub is_special_pos {
    my($i, $j, @matrix) = @_;
    return 0 if $matrix[$i][$j] != 1;
    for my $ii (0 .. $#matrix) {
        if ($ii != $i) {
            return 0 if $matrix[$ii][$j] != 0;
        }
    }
    for my $jj (0 .. $#{$matrix[0]}) {
        if ($jj != $j) {
            return 0 if $matrix[$i][$jj] != 0;
        }
    }
    return 1;
}
