#!/usr/bin/env perl

# Task 1: Maximum Ones
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a m x n binary matrix.
# Write a script to return the row number containing maximum ones, in case of more than one rows then return smallest row number.
# Example 1
# 
# Input: $matrix = [ [0, 1],
#                    [1, 0],
#                  ]
# Output: 1
# Row 1 and Row 2 have the same number of ones, so return row 1.
# 
# Example 2
# Input: $matrix = [ [0, 0, 0],
#                    [1, 0, 1],
#                  ]
# Output: 2
# Row 2 has the maximum ones, so return row 2.
# 
# Example 3
# Input: $matrix = [ [0, 0],
#                    [1, 1],
#                    [0, 0],
#                  ]
# Output: 2
# Row 2 have the maximum ones, so return row 2.

use strict;
use warnings;
use List::Util qw(sum max min);

my $matrix = [[0, 1],
              [1, 0]
             ];
maximum_ones($matrix);

$matrix = [[0, 0, 0],
           [1, 0, 1]
          ];
maximum_ones($matrix);

$matrix = [[0, 0],
           [1, 1],
           [0, 0]
          ];
maximum_ones($matrix);

exit 0;

sub maximum_ones {
    my $matrix = shift;
    my %rows = map { $_ => sum(@{$matrix->[$_]}) }
                 (0..(scalar(@$matrix)-1));
    my $max = max values %rows;
    printf "row %d\n",
        (min map { $rows{$_} == $max ? $_ : () } keys %rows ) + 1;
    return 0;
}
