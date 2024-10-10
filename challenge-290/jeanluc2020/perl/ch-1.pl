#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-290/#TASK1
#
# Task 1: Double Exist
# ====================
#
# You are given an array of integers, @ints.
#
# Write a script to find if there exist two indices $i and $j such that:
#
## 1) $i != $j
## 2) 0 <= ($i, $j) < scalar @ints
## 3) $ints[$i] == 2 * $ints[$j]
#
## Example 1
##
## Input: @ints = (6, 2, 3, 3)
## Output: true
##
## For $i = 0, $j = 2
## $ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]
#
## Example 2
##
## Input: @ints = (3, 1, 4, 13)
## Output: false
#
## Example 3
##
## Input: @ints = (2, 1, 4, 2)
## Output: true
##
## For $i = 2, $j = 3
## $ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]
#
############################################################
##
## discussion
##
############################################################
#
# We just walk the array twice in nested loops. If the indices $i
# and $j are different and ints[$i] == 2 * ints[$j] we return True.
# Otherwise, we don't fulfill the condition with this pair and
# continue looping. If in the end, we didn't find any matching pair,
# we can return False.

use strict;
use warnings;

double_exist(6, 2, 3, 3);
double_exist(3, 1, 4, 13);
double_exist(2, 1, 4, 2);

sub double_exist {
   my @ints = @_;
   print "Input: (", join(", ", @ints), ")\n";
   foreach my $i (0..$#ints) {
      foreach my $j (0..$#ints) {
         next if $i == $j;
         return print "Output: True\n" if $ints[$i] == 2 * $ints[$j];
      }
   }
   print "Output: False\n";
}
