#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-251/#TASK2
#
# Task 2: Lucky Numbers
# =====================
#
# You are given a m x n matrix of distinct numbers.
#
# Write a script to return the lucky number, if there is one, or -1 if not.
#
## A lucky number is an element of the matrix such that it is
## the minimum element in its row and maximum in its column.
#
## Example 1
##
## Input: $matrix = [ [ 3,  7,  8],
##                    [ 9, 11, 13],
##                    [15, 16, 17] ];
## Output: 15
##
## 15 is the only lucky number since it is the minimum in its row
## and the maximum in its column.
#
## Example 2
##
## Input: $matrix = [ [ 1, 10,  4,  2],
##                    [ 9,  3,  8,  7],
##                    [15, 16, 17, 12] ];
## Output: 12
#
## Example 3
##
## Input: $matrix = [ [7 ,8],
##                    [1 ,2] ];
## Output: 7
#
############################################################
##
## discussion
##
############################################################
#
# For a lucky number, we know:
# Since the minimum in a row is at the same time the maximum in
# a column, there is no number bigger in that column, so in all
# other rows, there is a number that is smaller than the current
# number, so the minimum in that other row has to be smaller or
# equal to this number; being smaller, it can't be bigger than any
# of the numbers in the original row, so it's can't be a lucky number
# as well.
# So we know we have at most one lucky number.
# Finding it is simple: In each row, find the minimum number, then
# check whether it is as well the maximum number in its column.

use strict;
use warnings;
use List::Util qw(min max);

lucky_numbers([ [ 3,  7,  8], [ 9, 11, 13], [15, 16, 17] ]);
lucky_numbers([ [ 1, 10,  4,  2], [ 9,  3,  8,  7], [15, 16, 17, 12] ]);
lucky_numbers([ [7 ,8], [1 ,2] ]);
lucky_numbers([ [7 ,8], [10 ,2] ]);

sub lucky_numbers {
   my $matrix = shift;
   print "Input: [\n";
   foreach my $row (@$matrix) {
      print "        [" . join(", ", @$row) . "],\n";
   }
   print "       ];\n";
   my $rows = scalar(@$matrix);
   my $columns = scalar(@{$matrix->[0]});
   my $row_min = [];
   my $column_max = [];
   foreach my $column (0..$columns-1) {
      my @column_elements = ();
      foreach my $row (0..$rows-1) {
         push @column_elements, $matrix->[$row]->[$column];
      }
      push @$column_max, max(@column_elements);
   }
   foreach my $i (0..$rows-1) {
      push @$row_min, min(@{$matrix->[$i]});
      foreach my $j (0..$columns-1) {
         my $elem = $matrix->[$i]->[$j];
         if($elem == $row_min->[$i] && $elem == $column_max->[$j]) {
            print "Output: $elem\n";
            return;
         }
      }
   }
   print "Output: -1\n";
}


