#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-222/#TASK1
#
# Task 1: Matching Members
# ========================
#
# You are given a list of positive integers, @ints.
#
# Write a script to find the total matching members after sorting the list
# increasing order.
#
## Example 1
## Input: @ints = (1, 1, 4, 2, 1, 3)
## Output: 3
##
## Original list: (1, 1, 4, 2, 1, 2)
## Sorted list  : (1, 1, 1, 2, 3, 4)
##
## Compare the two lists, we found 3 matching members (1, 1, 2).
#
## Example 2
##
## Input: @ints = (5, 1, 2, 3, 4)
## Output: 0
##
## Original list: (5, 1, 2, 3, 4)
## Sorted list  : (1, 2, 3, 4, 5)
##
## Compare the two lists, we found 0 matching members.
#
## Example 3
##
## Input: @ints = (1, 2, 3, 4, 5)
## Output: 5
##
## Original list: (1, 2, 3, 4, 5)
## Sorted list  : (1, 2, 3, 4, 5)
##
## Compare the two lists, we found 5 matching members.
#
############################################################
##
## discussion
##
############################################################
#
# create a sorted version of the list and compare one by one

use strict;
use warnings;

matching_members(1, 1, 4, 2, 1, 3);
matching_members(5, 1, 2, 3, 4);
matching_members(1, 2, 3, 4, 5);

sub matching_members {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my @sorted = sort { $a <=> $b } @ints;
   my $result = 0;
   foreach my $index (0..$#ints) {
      $result++ if $ints[$index] == $sorted[$index];
   }
   print "Output: $result\n";
}

