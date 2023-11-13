#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-243/#TASK1
#
# Task 1: Reverse Pairs
# =====================
#
# You are given an array of integers.
#
# Write a script to return the number of reverse pairs in the given
# array.
#
# A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length
# and b) nums[i] > 2 * nums[j].
#
## Example 1
##
## Input: @nums = (1, 3, 2, 3, 1)
## Output: 2
##
## (1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
## (3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1
#
## Example 2
##
## Input: @nums = (2, 4, 3, 5, 1)
## Output: 3
##
## (1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
## (2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
## (3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1
#
############################################################
##
## discussion
##
############################################################
#
# Walk the array twice (once from 0, once from the first index + 1)
# Check the condition in each case, counting the occurrences where
# the condition holds true.

use strict;
use warnings;

reverse_pairs(1, 3, 2, 3, 1);
reverse_pairs(2, 4, 3, 5, 1);

sub reverse_pairs {
   my @nums = @_;
   my $result = 0;
   print "Input: (" . join(", ", @nums) . ")\n";
   foreach my $i (0..$#nums) {
      foreach my $j ($i+1..$#nums) {
         $result++ if $nums[$i] > 2 * $nums[$j];
      }
   }
   print "Output: $result\n";
}
