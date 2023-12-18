#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-248/#TASK2
#
# Task 2: Submatrix Sum
# =====================
#
# You are given a NxM matrix A of integers.
#
# Write a script to construct a (N-1)x(M-1) matrix B having elements that are
# the sum over the 2x2 submatrices of A,
#
# b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]
#
# 
## Example 1
##
## Input: $a = [
##               [1,  2,  3,  4],
##               [5,  6,  7,  8],
##               [9, 10, 11, 12]
##             ]
##
## Output: $b = [
##                [14, 18, 22],
##                [30, 34, 38]
##              ]
#
## Example 2
##
## Input: $a = [
##               [1, 0, 0, 0],
##               [0, 1, 0, 0],
##               [0, 0, 1, 0],
##               [0, 0, 0, 1]
##             ]
##
## Output: $b = [
##                [2, 1, 0],
##                [1, 2, 1],
##                [0, 1, 2]
##              ]
#
############################################################
##
## discussion
##
############################################################
#
# Just some index arithmetic

submatrix_sum( [ [1,  2,  3,  4], [5,  6,  7,  8], [9, 10, 11, 12] ] );
submatrix_sum( [ [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1] ] );

sub submatrix_sum {
   my $matrix = shift;
   print "Input: [\n";
   foreach my $array (@$matrix) {
      print "        [" . join(",", @$array) . "],\n";
   }
   print "       ]\n";
   my $l = scalar(@$matrix);
   my $m = scalar(@{$matrix->[0]});
   my $resultmatrix = [];
   foreach my $i (0..$l-2) {
      foreach my $k (0..$m-2) {
         $resultmatrix->[$i]->[$k] = $matrix->[$i]->[$k] + $matrix->[$i]->[$k+1] + $matrix->[$i+1]->[$k] + $matrix->[$i+1]->[$k+1];
      }
   }
   print "Output: [\n";
   foreach my $array (@$resultmatrix) {
      print "         [" . join(",", @$array) . "],\n";
   }
   print "        ]\n";
}
