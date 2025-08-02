#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-302/#TASK2
#
# Task 2: Step by Step
# ====================
#
# You are given an array of integers, @ints.
#
# Write a script to find the minimum positive start value such that step by
# step sum is never less than one.
#
## Example 1
##
## Input: @ints = (-3, 2, -3, 4, 2)
## Output: 5
##
## For start value 5.
## 5 + (-3) = 2
## 2 + (+2) = 4
## 4 + (-3) = 1
## 1 + (+4) = 5
## 5 + (+2) = 7
#
## Example 2
##
## Input: @ints = (1, 2)
## Output: 1
#
## Example 3
##
## Input: @ints = (1, -2, -3)
## Output: 5
#
############################################################
##
## discussion
##
############################################################
#
# Starting with a value of 1, we calculate the step by step
# sum and keep trackf of the minimum. If it is < 1, we can
# calculate the minimum required positive start value from
# that minimum step sum. Otherwise we can use 1 as the result.

use strict;
use warnings;

step_by_step(-3, 2, -3, 4, 2);
step_by_step(1, 2);
step_by_step(1, -2, -3);

sub step_by_step {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $start = 1;
   my $min = 1;
   foreach my $elem (@ints) {
      $start += $elem;
      if($start < $min) {
         $min = $start;
      }
   }
   if($min < 1) {
      my $tmp = 2 - $min;
      print "Output: $tmp\n";
   } else {
      print "Output: 1\n";
   }
}
