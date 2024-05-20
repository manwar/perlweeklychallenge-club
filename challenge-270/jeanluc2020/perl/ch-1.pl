#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-270/#TASK1
#
# Task 1: Special Positions
# =========================
#
# You are given a m x n binary matrix.
#
# Write a script to return the number of special positions in the given binary matrix.
#
## A position (i, j) is called special if $matrix[i][j] == 1 and all other elements in the row i and column j are 0.
#
## Example 1
##
## Input: $matrix = [ [1, 0, 0],
##                    [0, 0, 1],
##                    [1, 0, 0],
## ]
## Output: 1
##
## There is only one special position (1, 2) as $matrix[1][2] == 1
## and all other elements in row 1 and column 2 are 0.
#
## Example 2
##
## Input: $matrix = [ [1, 0, 0],
##                    [0, 1, 0],
##                    [0, 0, 1],
## ]
## Output: 3
##
## Special positions are (0,0), (1, 1) and (2,2).
#
############################################################
##
## discussion
##
############################################################
#
# We walk the matrix and for each position we check whether
# the position is special.
# For this we use a function that just checks the same column
# in all rows, and checks the same row for all columns. If
# row and column are the target row and column, we conclude the
# point is not special if it isn't 1, for all other values we
# conclude the point is not special if it isn't 0. If we reach
# the end and we didn't eliminate the point as not special, then
# we conclude this point is special.

use strict;
use warnings;

special_positions( [ [1, 0, 0], [0, 0, 1], [1, 0, 0], ] );
special_positions( [ [1, 0, 0], [0, 1, 0], [0, 0, 1], ] );

sub special_positions {
   my $matrix = shift;
   my @rows = @$matrix;
   my $num_rows = scalar(@rows);
   my $num_columns = scalar(@{$rows[0]});
   my $special = 0;
   foreach my $i (0..$num_rows-1) {
      foreach my $j (0..$num_columns-1) {
         if(is_special($i, $j, $num_rows, $num_columns, $matrix)) {
            $special++;
         }
      }
   }
   print "Output: $special\n";
}

sub is_special {
   my ($i, $j, $num_rows, $num_columns, $matrix) = @_;
   foreach my $row (0..$num_rows-1) {
      if($i == $row) {
         return 0 if $matrix->[$row]->[$j] != 1;
      } else {
         return 0 if $matrix->[$row]->[$j] != 0;
      }
   }
   foreach my $column (0..$num_columns-1) {
      if($j == $column) {
         return 0 if $matrix->[$i]->[$column] != 1;
      } else {
         return 0 if $matrix->[$i]->[$column] != 0;
      }
   }
   return 1;
}

