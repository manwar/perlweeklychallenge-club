#!/usr/bin/env perl

# Challenge 266
#
# Task 2: X Matrix
# Submitted by: Mohammad Sajid Anwar
#
# You are given a square matrix, $matrix.
#
# Write a script to find if the given matrix is X Matrix.
#
#     A square matrix is an X Matrix if all the elements on the main diagonal
#     and antidiagonal are non-zero and everything else are zero.
#
# Example 1
#
# Input: $matrix = [ [1, 0, 0, 2],
#                    [0, 3, 4, 0],
#                    [0, 5, 6, 0],
#                    [7, 0, 0, 1],
#                  ]
# Output: true
#
# Example 2
#
# Input: $matrix = [ [1, 2, 3],
#                    [4, 5, 6],
#                    [7, 8, 9],
#                  ]
# Output: false
#
# Example 3
#
# Input: $matrix = [ [1, 0, 2],
#                    [0, 3, 0],
#                    [4, 0, 5],
#                  ]
# Output: true

use Modern::Perl;

my @matrix = parse_matrix("@ARGV");
say is_x(@matrix) ? 'true' : 'false';

sub parse_matrix {
    my($text) = @_;
    my @lines = split /,/, $text;
    my @matrix = map {[split ' ', $_]} @lines;
    return @matrix;
}

sub is_x {
    my(@matrix) = @_;

    return 0 if scalar(@matrix) != scalar(@{$matrix[0]});   # not square

    for my $i (0 .. $#matrix) {
        for my $j (0 .. $#matrix) {
            if ($i == $j || $#matrix - $i == $j) {
                return 0 if $matrix[$i][$j] == 0;
            }
            else {
                return 0 if $matrix[$i][$j] != 0;
            }
        }
    }

    return 1;
}
