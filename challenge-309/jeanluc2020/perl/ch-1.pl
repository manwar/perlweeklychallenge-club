#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-309/#TASK1
#
# Task 1: Min Gap
# ===============
#
# You are given an array of integers, @ints, increasing order.
#
# Write a script to return the element before which you find the smallest gap.
#
## Example 1
##
## Input: @ints = (2, 8, 10, 11, 15)
## Output: 11
##
##  8 - 2  => 6
## 10 - 8  => 2
## 11 - 10 => 1
## 15 - 11 => 4
##
## 11 is where we found the min gap.
#
## Example 2
##
## Input: @ints = (1, 5, 6, 7, 14)
## Output: 6
##
##  5 - 1 => 4
##  6 - 5 => 1
##  7 - 6 => 1
## 14 - 7 => 7
##
## 6 and 7 where we found the min gap, so we pick the first instance.
#
## Example 3
##
## Input: @ints = (8, 20, 25, 28)
## Output: 28
##
##  8 - 20 => 14
## 25 - 20 => 5
## 28 - 25 => 3
##
## 28 is where we found the min gap.
#
############################################################
##
## discussion
##
############################################################
#
# This one is straight forward: Walk the array from left to right.
# Whenever we find a smaller gap, we keep track of the new min gap
# and the element at that position. We can then return the remembered
# element in the end.

use v5.36;

min_gap(2, 8, 10, 11, 15);
min_gap(1, 5, 6, 7, 14);
min_gap(8, 20, 25, 28);

sub min_gap(@ints) {
   say "Input: (" . join(", ", @ints) . ")";
   my $min = undef;
   my $elem = undef;
   foreach my $i (1..$#ints) {
      my $gap = $ints[$i] - $ints[$i-1];
      if ( ! defined($min) or $gap < $min ) {
         $min = $gap;
         $elem = $ints[$i];
      }
   }
   say "Output: $elem";
}
