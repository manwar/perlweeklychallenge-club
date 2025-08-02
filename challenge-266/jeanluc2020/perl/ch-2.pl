#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-266/#TASK2
#
# Task 2: X Matrix
# ================
#
# You are given a square matrix, $matrix.
#
# Write a script to find if the given matrix is X Matrix.
#
### A square matrix is an X Matrix if all the elements on the main diagonal and
### antidiagonal are non-zero and everything else are zero.
#
## Example 1
##
## Input: $matrix = [ [1, 0, 0, 2],
##                    [0, 3, 4, 0],
##                    [0, 5, 6, 0],
##                    [7, 0, 0, 1],
##                  ]
## Output: true
#
## Example 2
##
## Input: $matrix = [ [1, 2, 3],
##                    [4, 5, 6],
##                    [7, 8, 9],
##                  ]
## Output: false
#
## Example 3
##
## Input: $matrix = [ [1, 0, 2],
##                    [0, 3, 0],
##                    [4, 0, 5],
##                  ]
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# So we just walk the matrix using an index $i for the rows and another
# index $j for the columns. If we're on the diagonals, we check whether
# the value is != 0, otherwise we check whether it is == 0.

use strict;
use warnings;

x_matrix( [ [1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1] ] );
x_matrix( [ [1, 2, 3], [4, 5, 6], [7, 8, 9] ] );
x_matrix( [ [1, 0, 2], [0, 3, 0], [4, 0, 5] ] );

sub x_matrix {
   my $matrix = shift;
   my $rows = scalar(@$matrix);
   my $columns = scalar(@{$matrix->[0]});
   print "Input: [\n";
   foreach my $row (@$matrix) {
      print "        [ ", join(", ", @$row), "],\n";
   }
   print "]\n";
   die "Not a square matrix" unless $rows == $columns;
   my $is_x_matrix = 1;
   foreach my $i (0..$rows-1) {
      foreach my $j (0..$columns-1) {
         if($i==$j or $i == ($columns - 1 - $j)) {
            $is_x_matrix = 0 unless $matrix->[$i]->[$j] != 0;
         } else {
            $is_x_matrix = 0 unless $matrix->[$i]->[$j] == 0;
         }
      }
   }
   print "Output: ", $is_x_matrix == 0 ? "false" : "true", "\n";
}
