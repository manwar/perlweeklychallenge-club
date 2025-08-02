#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-271/#TASK1
#
# Task 1: Maximum Ones
# ====================
#
# You are given a m x n binary matrix.
#
# Write a script to return the row number containing maximum ones, in case of
# more than one rows then return smallest row number.
#
## Example 1
##
## Input: $matrix = [ [0, 1],
##                    [1, 0],
##                  ]
## Output: 1
##
## Row 1 and Row 2 have the same number of ones, so return row 1.
#
## Example 2
##
## Input: $matrix = [ [0, 0, 0],
##                    [1, 0, 1],
##                  ]
## Output: 2
##
## Row 2 has the maximum ones, so return row 2.
#
## Example 3
##
## Input: $matrix = [ [0, 0],
##                    [1, 1],
##                    [0, 0],
##                  ]
## Output: 2
##
## Row 2 have the maximum ones, so return row 2.
#
############################################################
##
## discussion
##
############################################################
#
# We walk the matrix row by row. If the number of 1s is higher
# than the previous maximum we have both a new maximum and the
# new index of this maximum. In the end, return the index.

use strict;
use warnings;

maximum_ones( [ [0, 1], [1, 0] ] );
maximum_ones( [ [0, 0, 0], [1, 0, 1] ] );
maximum_ones( [ [0, 0], [1, 1], [0, 0] ] );

sub maximum_ones {
   my $matrix = shift;
   print "Input: [\n";
   foreach my $row (@$matrix) {
      print "         [", join(", ", @$row), "],\n";
   }
   print "       ]\n";
   my $max_ones = 0;
   my $max_index = 1;
   my $index = 0;
   foreach my $row (@$matrix) {
      $index++;
      my $count = 0;
      foreach my $elem (@$row) {
         $count++ if $elem == 1;
      }
      if($count > $max_ones) {
         $max_index = $index;
         $max_ones = $count;
      }
   }
   print "Output: $max_ones\n";
}
