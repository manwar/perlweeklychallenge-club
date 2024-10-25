#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-292/#TASK1
#
# Task 1: Twice Largest
# =====================
#
# You are given an array of integers, @ints, where the largest integer is unique.
#
# Write a script to find whether the largest element in the array is at least
# twice as big as every element in the given array. If it is return the index
# of the largest element or return -1 otherwise.
#
## Example 1
##
## Input: @ints = (2, 4, 1, 0)
## Output: 1
##
## The largest integer is 4.
## For every other elements in the given array is at least twice as big.
## The index value of 4 is 1.
#
## Example 2
##
## Input: @ints = (1, 2, 3, 4)
## Output: -1
##
## The largest integer is 4.
## 4 is less than twice the value of 3, so we return -1.
#
############################################################
##
## discussion
##
############################################################
#
# We find the maximum value. Then we walk the array. If a value
# is indentical to the maximum, we found the index. Otherwise,
# if double of the value is bigger than the max, we return -1.
# In the end, we return the index.

use strict;
use warnings;
use List::Util qw(max);

twice_largest(2, 4, 1, 0);
twice_largest(1, 2, 3, 4);

sub twice_largest {
   my @ints = @_;
   my $m = max(@ints);
   print "Input: (" . join(", ", @ints) . ")\n";
   my $index = -1;
   foreach my $i (0..$#ints) {
      if($ints[$i] == $m) {
         $index = $i;
         next;
      } else {
         if( 2 * $ints[$i] > $m) {
            return print "Output: -1\n";
         }
      }
   }
   return print "Output: $index\n";
}
