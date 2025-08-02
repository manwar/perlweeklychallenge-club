#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/#TASK2
#
# Task 2: Count Equal Divisible
# =============================
#
# You are given an array of integers, @ints and an integer $k.
#
# Write a script to return the number of pairs (i, j) where
#
# a) 0 <= i < j < size of @ints
# b) ints[i] == ints[j]
# c) i x j is divisible by k
#
## Example 1
##
## Input: @ints = (3,1,2,2,2,1,3) and $k = 2
## Output: 4
##
## (0, 6) => ints[0] == ints[6] and 0 x 6 is divisible by 2
## (2, 3) => ints[2] == ints[3] and 2 x 3 is divisible by 2
## (2, 4) => ints[2] == ints[4] and 2 x 4 is divisible by 2
## (3, 4) => ints[3] == ints[4] and 3 x 4 is divisible by 2
#
## Example 2
##
## Input: @ints = (1,2,3) and $k = 1
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# Have one index variable go from 0 to size of @ints - 1, then
# another walk from the first index + 1 to size of @ints - 1. In
# case ints[i] == ints[j], check if the product of i and j is
# divisible by $k. Return the sum of all instances where this is true.

use strict;
use warnings;

count_equal_divisible( [3,1,2,2,2,1,3], 2);
count_equal_divisible( [1,2,3], 1);

sub count_equal_divisible {
   my ($tmp, $k) = @_;
   my @ints = @$tmp;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $result = 0;
   foreach my $i (0 .. $#ints) {
      foreach my $j ($i+1 .. $#ints) {
         if($ints[$i] == $ints[$j]) {
            $result++ unless $i * $j % $k;
         }
      }
   }
   print "Output: $result\n";
}
