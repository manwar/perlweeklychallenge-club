#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-219/#TASK1
#
# Task 1: Sorted Squares
# ======================
#
# You are given a list of numbers.
#
# Write a script to square each number in the list and return the sorted list, increasing order.
#
## Example 1
##
## Input: @list = (-2, -1, 0, 3, 4)
## Output: (0, 1, 4, 9, 16)
#
## Example 2
##
## Input: @list = (5, -4, -1, 3, 6)
## Output: (1, 9, 16, 25, 36)
#
############################################################
##
## discussion
##
############################################################
#
# Just square everything, then sort.

use strict;
use warnings;

sorted_squares(-2, -1, 0, 3, 4);
sorted_squares(5, -4, -1, 3, 6);

sub sorted_squares {
   my @list = @_;
   print "Input: (" . join(", ", @list) . ")\n";
   print "Output: (" . join(", ", sort {$a<=>$b} map {$_*$_} @list) . ")\n";
}
