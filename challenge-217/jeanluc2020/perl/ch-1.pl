#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-217/#TASK1
#
# Task 1: Sorted Matrix
# =====================
#
# You are given a n x n matrix where n >= 2.
#
# Write a script to find 3rd smallest element in the sorted matrix.
#
## Example 1
##
## Input: @matrix = ([3, 1, 2], [5, 2, 4], [0, 1, 3])
## Output: 1
##
## The sorted list of the given matrix: 0, 1, 1, 2, 2, 3, 3, 4, 5.
## The 3rd smallest of the sorted list is 1.
#
## Example 2
##
## Input: @matrix = ([2, 1], [4, 5])
## Output: 4
##
## The sorted list of the given matrix: 1, 2, 4, 5.
## The 3rd smallest of the sorted list is 4.
#
## Example 3
##
## Input: @matrix = ([1, 0, 3], [0, 0, 0], [1, 2, 1])
## Output: 0
##
## The sorted list of the given matrix: 0, 0, 0, 0, 1, 1, 1, 2, 3.
## The 3rd smallest of the sorted list is 0.
#
############################################################
##
## discussion
##
############################################################
#
# This is straight forward. First, we create an array that
# consists of all elements from the matrix - @all in our case,
# which we fill while printing the input matrix.
# Then, we sort that. From the sorted array, we print the third
# element as the output.

use strict;
use warnings;

sorted_matrix([3, 1, 2], [5, 2, 4], [0, 1, 3]);
sorted_matrix([2, 1], [4, 5]);
sorted_matrix([1, 0, 3], [0, 0, 0], [1, 2, 1]);

sub sorted_matrix {
   my @matrix = @_;
   print "Input: (";
   my @all = ();
   my $first = 1;
   foreach my $part (@matrix) {
      print ", " unless $first;
      $first = 0;
      print "[" . join(",",@$part) . "]";
      push @all, @$part;
   }
   print ")\n";
   my @sorted = sort {$a<=>$b} @all;
   print "Output: $sorted[2]\n";
}

