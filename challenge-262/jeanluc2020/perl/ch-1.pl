#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/#TASK1
#
# Task 1: Max Positive Negative
# =============================
#
# You are given an array of integers, @ints.
#
# Write a script to return the maximum number of either positive or negative
# integers in the given array.
#
## Example 1
##
## Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
## Output: 4
##
## Count of positive integers: 4
## Count of negative integers: 3
## Maximum of count of positive and negative integers: 4
#
## Example 2
##
## Input: @ints = (-1, -2, -3, 1)
## Output: 3
##
## Count of positive integers: 1
## Count of negative integers: 3
## Maximum of count of positive and negative integers: 3
#
## Example 3
##
## Input: @ints = (1,2)
## Output: 2
##
## Count of positive integers: 2
## Count of negative integers: 0
## Maximum of count of positive and negative integers: 2
#
############################################################
##
## discussion
##
############################################################
#
# Simply count the negatives and the positives, then return
# the bigger of the two numbers.

use strict;
use warnings;

max_positive_negative(-3, 1, 2, -1, 3, -2, 4);
max_positive_negative(-1, -2, -3, 1);
max_positive_negative(1,2);

sub max_positive_negative {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $pos = 0;
   my $neg = 0;
   foreach my $num (@ints) {
      if($num < 0) {
         $neg++;
      } else {
         $pos++;
      }
   }
   my $result = ($pos > $neg) ? $pos : $neg;
   print "Output: $result\n";
}

