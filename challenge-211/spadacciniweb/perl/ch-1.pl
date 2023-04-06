#!/usr/bin/env perl

# Task 1: Toeplitz Matrix
# Submitted by: Mohammad S Anwar
# 
# You are given a matrix m x n.
# Write a script to find out if the given matrix is Toeplitz Matrix.
# A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.
# 
# 
# Example 1
# Input: @matrix = [ [4, 3, 2, 1],
#                    [5, 4, 3, 2],
#                    [6, 5, 4, 3],
#                  ]
# Output: true
# 
# Example 2
# Input: @matrix = [ [1, 2, 3],
#                    [3, 2, 1],
#                  ]
# Output: false

use strict;
use warnings;
use feature qw/say/;

sub check_toeplitz {;
    my $matrix = shift;
    my $rows = @$matrix;
    my $cols = scalar @{$matrix->[0]};
    my $min = ($rows < $cols)
        ? $rows
        : $cols;
    my $value = $matrix->[0]->[0];
    foreach my $i (0..$min-1) {
        return 'false'
            unless $matrix->[$i]->[$i] == $value;
    }
    return 'true';
}

my $matrix = [ [4, 3, 2, 1],
               [5, 4, 3, 2],
               [6, 5, 4, 3],
             ];
say check_toeplitz($matrix);

$matrix = [ [1, 2, 3],
            [3, 2, 1],
          ];
say check_toeplitz($matrix);

