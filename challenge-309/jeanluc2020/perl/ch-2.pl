#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-309/#TASK2
#
# Task 2: Min Diff
# ================
#
# You are given an array of integers, @ints.
#
# Write a script to find the minimum difference between any two elements.
#
## Example 1
##
## Input: @ints = (1, 5, 8, 9)
## Output: 1
##
## 1, 5 => 5 - 1 => 4
## 1, 8 => 8 - 1 => 7
## 1, 9 => 9 - 1 => 8
## 5, 8 => 8 - 5 => 3
## 5, 9 => 9 - 5 => 4
## 8, 9 => 9 - 8 => 1
#
## Example 2
##
## Input: @ints = (9, 4, 1, 7)
## Output: 2
##
## 9, 4 => 9 - 4 => 5
## 9, 1 => 9 - 1 => 8
## 9, 7 => 9 - 7 => 2
## 4, 1 => 4 - 1 => 3
## 4, 7 => 7 - 4 => 3
## 1, 7 => 7 - 1 => 6
#
############################################################
##
## discussion
##
############################################################
#
# We just calculate all possible differences, keeping track
# of the minimum.

use v5.36;

min_diff(1, 5, 8, 9);
min_diff(9, 4, 1, 7);

sub min_diff(@ints) {
   say "Input: (" . join(", ", @ints) . ")";
   return say "Output: undef" unless $#ints > 0;
   my $min = abs($ints[0] - $ints[1]);
   foreach my $i (0..$#ints) {
      foreach my $j ($i+1..$#ints) {
         my $diff = abs($ints[$i] - $ints[$j]);
         $min = $diff if $diff < $min;
      }
   }
   say "Output: $min";
}
