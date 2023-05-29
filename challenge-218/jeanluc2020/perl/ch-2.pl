#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-218/#TASK2
#
# Task 2: Matrix Score
# ====================
#
# You are given a m x n binary matrix i.e. having only 1 and 0.
#
# You are allowed to make as many moves as you want to get the highest score.
#
###  A move can be either toggling each value in a row or column.
#
# To get the score, convert the each row binary to dec and return the sum.
#
## Example 1:
##
## Input: @matrix = [ [0,0,1,1],
##                    [1,0,1,0],
##                    [1,1,0,0], ]
## Output: 39
##
## Move #1: convert row #1 => 1100
##          [ [1,1,0,0],
##            [1,0,1,0],
##            [1,1,0,0], ]
##
## Move #2: convert col #3 => 101
##          [ [1,1,1,0],
##            [1,0,0,0],
##            [1,1,1,0], ]
##
## Move #3: convert col #4 => 111
##          [ [1,1,1,1],
##            [1,0,0,1],
##            [1,1,1,1], ]
##
## Score: 0b1111 + 0b1001 + 0b1111 => 15 + 9 + 15 => 39
#
## Example 2:
##
## Input: @matrix = [ [0] ]
## Output: 1
#
############################################################
##
## discussion
##
############################################################
#
# Each row and each column can either be flipped or not, since
# flipping it twice returns it into its previous state. So we
# can get all possible scores by calculating the score with
# each column and row either flipped or not and then select
# the maximum. To calculate each combination, we can say we flip
# row $i if the $i-th bit of a bitfield is set, and column $i
# if the ($i-$number_of_rows)-th bit of the bitfield is set.
# In order to create the bitfield, we count from 0 to
# 2**($rows+$columns)-1 and convert the result into a bitfield
# of length ($rows+$columns). Then we calculate the new matrix
# with the corresponding rows and columns flipped, and then the
# score for this new matrix. In the end we take the maximum of
# those values.

use strict;
use warnings;

matrix_score( [ [0,0,1,1], [1,0,1,0], [1,1,0,0], ] );
matrix_score( [ [0] ] );

sub matrix_score {
   my $matrix = shift;
   my ($rows, $columns) = get_dimensions($matrix);
   my $highest = 0;
   print "Input:\n";
   print_matrix($matrix);
   foreach my $index (0..2**($rows+$columns)-1) {
      my $score = get_score($matrix, $index, $rows, $columns);
      $highest = $score if $score > $highest;
   }
   print "Output: $highest\n";
}

# this helper function calculates the number of rows and columns
# of the matrix, and also checks if all rows have the same amount
# of columns
sub get_dimensions {
   my $matrix = shift;
   my $rows = @$matrix;
   my $columns = scalar(@{$matrix->[0]});
   foreach my $row (@$matrix) {
      my $c = scalar(@$row);
      die "Not a matrix, dimension mismatch!" unless $c == $columns;
   }
   return ($rows, $columns);
}

# helper function to print the matrix, just for the output
sub print_matrix {
   my $matrix = shift;
   my $first = 1;
   foreach my $row (@$matrix) {
      if($first) {
         $first = 0;
         print "[ ";
      } else {
         print "  ";
      }
      print "[" . join(",", @$row) . "],\n";
   }
   print "]\n";
}

# given the original matrix and the index (the number we will turn
# into the bitfield for determining which rows and columns to flip),
# this function will first create a copy of the matrix, then flip
# the corresponding rows and columns, and then calculate the score.
sub get_score {
   my ($matrix, $index, $rows, $columns) = @_;
   my $copy_matrix;
   # create a copy of the matrix
   foreach my $row (0..$rows-1) {
      foreach my $column (0..$columns-1) {
         $copy_matrix->[$row]->[$column] = $matrix->[$row]->[$column];
      }
   }
   # turn the index into a bitfield
   my $x = $rows+$columns;
   my @bits = split //, sprintf("%0${x}b", $index);
   foreach my $i (0..$rows+$columns-1) {
      if($bits[$i]) { # the bit is set
         if($i < $rows) {
            # flip everything in row $i
            foreach my $j (0..$columns-1) {
               $copy_matrix->[$i]->[$j] = $copy_matrix->[$i]->[$j] ? 0 : 1;
            }
         } else {
            # flip everything in column $i-$rows
            foreach my $j (0..$rows-1) {
               $copy_matrix->[$j]->[$i-$rows] = $copy_matrix->[$j]->[$i-$rows] ? 0 : 1;
            }
         }
      }
   }
   # calculate the score
   my $score = 0;
   foreach my $row (0..$rows-1) {
      $score += bin_to_dec($copy_matrix->[$row]);
   }
   return $score;
}

# helper function to turn an array of bits into an integer
sub bin_to_dec {
   my $digits = shift;
   my $result = 0;
   foreach my $digit (@$digits) {
      $result*=2;
      $result+=$digit;
   }
   return $result;
}

