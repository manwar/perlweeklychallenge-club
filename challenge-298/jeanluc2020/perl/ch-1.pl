#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-298/#TASK1
#
# Task 1: Maximal Square
# ======================
#
# You are given an m x n binary matrix with 0 and 1 only.
#
# Write a script to find the largest square containing only 1's and return it’s
# area.
#
## Example 1
##
## Input: @matrix = ([1, 0, 1, 0, 0],
##                   [1, 0, 1, 1, 1],
##                   [1, 1, 1, 1, 1],
##                   [1, 0, 0, 1, 0])
## Output: 4
##
## Two maximal square found with same size marked as 'x':
##
## [1, 0, 1, 0, 0]
## [1, 0, x, x, 1]
## [1, 1, x, x, 1]
## [1, 0, 0, 1, 0]
##
## [1, 0, 1, 0, 0]
## [1, 0, 1, x, x]
## [1, 1, 1, x, x]
## [1, 0, 0, 1, 0]
#
## Example 2
##
## Input: @matrix = ([0, 1],
##                   [1, 0])
## Output: 1
##
## Two maximal square found with same size marked as 'x':
##
## [0, x]
## [1, 0]
##
## [0, 1]
## [x, 0]
#
## Example 3
##
## Input: @matrix = ([0])
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# We produce all possible squares by creating the indices of
# their corners. Then we calculate the area of each of those,
# which is 0 if any of its fields is != 1, and the amount of
# 1's otherwise. We keep the maximum of those areas and return
# it at the end.

use strict;
use warnings;

maximal_square([1, 0, 1, 0, 0], [1, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 0, 0, 1, 0]);
maximal_square([0, 1], [1, 0]);
maximal_square([0]);

sub maximal_square {
   my @matrix = @_;
   print "Input: (\n";
   foreach my $line (@matrix) {
      print "   [" . join(", ", @$line) . "],\n";
   }
   print ")\n";
   my $max = 0;
   my @first_line = @{$matrix[0]};
   foreach my $i (0..$#matrix) {
      foreach my $j ($i..$#matrix) {
         foreach my $k (0..$#first_line) {
            foreach my $l ($k..$#first_line) {
               next if ($j-$i) != ($l-$k);
               my $area = check($i, $j, $k , $l, \@matrix);
               $max = $area if $area > $max;
            }
         }
      }
   }
   print "Output: $max\n";
}

sub check {
   my ($lower_line, $upper_line, $lower_column, $upper_column, $matrix) = @_;
   my $area = 0;
   foreach my $i ($lower_line..$upper_line) {
      foreach my $j ($lower_column..$upper_column) {
         return 0 unless $matrix->[$i]->[$j];
         $area++;
      }
   }
   return $area;
}

