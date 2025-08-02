#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-257/#TASK2
#
# Task 2: Reduced Row Echelon
# ===========================
#
# Given a matrix M, check whether the matrix is in reduced row echelon form.
#
# A matrix must have the following properties to be in reduced row echelon form:
#
# 1. If a row does not consist entirely of zeros, then the first
#    nonzero number in the row is a 1. We call this the leading 1.
# 2. If there are any rows that consist entirely of zeros, then
#    they are grouped together at the bottom of the matrix.
# 3. In any two successive rows that do not consist entirely of zeros,
#    the leading 1 in the lower row occurs farther to the right than
#    the leading 1 in the higher row.
# 4. Each column that contains a leading 1 has zeros everywhere else
#    in that column.
#
# For example:
#
# [
#    [1,0,0,1],
#    [0,1,0,2],
#    [0,0,1,3]
# ]
#
# The above matrix is in reduced row echelon form since the first nonzero
# number in each row is a 1, leading 1s in each successive row are farther to
# the right, and above and below each leading 1 there are only zeros.
#
# For more information check out this wikipedia article.
#
## Example 1
##
##     Input: $M = [
##                       [1, 1, 0],
##                       [0, 1, 0],
##                       [0, 0, 0]
##                 ]
## Output: 0
#
## Example 2
##
##     Input: $M = [
##                       [0, 1,-2, 0, 1],
##                       [0, 0, 0, 1, 3],
##                       [0, 0, 0, 0, 0],
##                       [0, 0, 0, 0, 0]
##                 ]
## Output: 1
#
## Example 3
##
##     Input: $M = [
##                       [1, 0, 0, 4],
##                       [0, 1, 0, 7],
##                       [0, 0, 1,-1]
##                 ]
## Output: 1
#
## Example 4
##
##     Input: $M = [
##                       [0, 1,-2, 0, 1],
##                       [0, 0, 0, 0, 0],
##                       [0, 0, 0, 1, 3],
##                       [0, 0, 0, 0, 0]
##                 ]
## Output: 0
#
## Example 5
##
##     Input: $M = [
##                       [0, 1, 0],
##                       [1, 0, 0],
##                       [0, 0, 0]
##                 ]
## Output: 0
#
## Example 6
##
##     Input: $M = [
##                       [4, 0, 0, 0],
##                       [0, 1, 0, 7],
##                       [0, 0, 1,-1]
##                 ]
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# Check all of the conditions one by one. Return the correct
# result.

use strict;
use warnings;

reduced_row_echelon( [ [1, 1, 0], [0, 1, 0], [0, 0, 0] ] );
reduced_row_echelon( [ [0, 1,-2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0] ] );
reduced_row_echelon( [ [1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1,-1] ] );
reduced_row_echelon( [ [0, 1,-2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0] ] );
reduced_row_echelon( [ [0, 1, 0], [1, 0, 0], [0, 0, 0] ] );
reduced_row_echelon( [ [4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1,-1] ] );

sub reduced_row_echelon {
   my $M = shift;
   # set some variables for better handling
   my @matrix_rows = @$M;
   my $rows = @matrix_rows;
   my $columns = length($matrix_rows[0]);
   # check that all rows are of the same length, otherwise this isn't a matrix
   foreach my $i (0..$rows-1) {
      if(length($matrix_rows[$i]) != $columns) {
         print "Not a matrix: Not all rows have the same number of columns!\n";
         return;
      }
   }
   # print the input matrix
   print "Input: [\n";
   foreach my $row (@matrix_rows) {
      print "         [" . join(", ", @$row) . "],\n";
   }
   print "       ]\n";
   # initialize a few helper variables
   my $last_starting_one = -1;
   my $row_num = -1;
   my $found_all_zeroes = 0;
   # for each row, check all the conditions
   foreach my $row (@matrix_rows) {
      $row_num++;
      my @row_ = @$row;
      # find first non-zero number in row
      my $first_non_zero = -1;
      foreach my $i (0..$#row_) {
         if($row_[$i] != 0) {
            if($row_[$i] == 1) {
               $first_non_zero = $i;
            } else {
               # we found the first non-zero number, but it's != 1
               # first condition not met
               print "Output: 0\n";
               return;
            }
            last;
         }
      }
      if($first_non_zero == -1) {
         # this row consists entirely of zeroes
         $found_all_zeroes = 1;
      }
      if($found_all_zeroes && $first_non_zero != -1) {
         # we found a row with all zeroes before, but now we have a non-zero element in the row
         # condition 2 not met
         print "Output: 0\n";
         return;
      }
      if($first_non_zero != -1 && $first_non_zero <= $last_starting_one) {
         # our first non-zero element is before the first non-zero in the previous row
         # condition 3 not met
         print "Output: 0\n";
         return;
      }
      $last_starting_one = $first_non_zero; # for the next round
      foreach my $j (0..$#matrix_rows) {
         next if $j == $row_num;
         if($matrix_rows[$j]->[$first_non_zero] != 0 && $first_non_zero >= 0) {
            # we found a row that has a non-zero value in the column that matches
            # the first non-zero column in the row we're currently considering
            # condition 4 not met
            print "Output: 0\n";
            return;
         }
      }
   }
   print "Output: 1\n";
}
