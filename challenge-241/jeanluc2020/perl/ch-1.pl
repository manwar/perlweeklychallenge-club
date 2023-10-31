#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-241/#TASK1
#
# Task 1: Arithmetic Triplets
# ===========================
#
# You are given an array (3 or more members) of integers in increasing order
# and a positive integer.
#
# Write a script to find out the number of unique Arithmetic Triplets
# satisfying the following rules:
#
# a) i < j < k
# b) nums[j] - nums[i] == diff
# c) nums[k] - nums[j] == diff
#
## Example 1
##
## Input: @nums = (0, 1, 4, 6, 7, 10)
##        $diff = 3
## Output: 2
##
## Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3.
## Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3.
#
## Example 2
##
## Input: @nums = (4, 5, 6, 7, 8, 9)
##        $diff = 2
## Output: 2
##
## (0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
## (1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.
#
############################################################
##
## discussion
##
############################################################
#
# Looping over the indices i, j, k we just check the condition.
# We can even short-curcuit the inner loop because we only need
# to execute it if $nums[$j] - $nums[$i] == $diff.

use strict;
use warnings;

arithmetic_triplets( [0, 1, 4, 6, 7, 10], 3 );
arithmetic_triplets( [4, 5, 6, 7, 8, 9], 2);

sub arithmetic_triplets {
   my ($nums, $diff) = @_;
   my @nums = @$nums;
   my $result = 0;
   print "Input: (" . join(", ", @nums) . "), $diff\n";
   foreach my $i (0..$#nums) {
      foreach my $j ($i+1..$#nums) {
         if($nums[$j] - $nums[$i] == $diff) {
            foreach my $k ($j+1..$#nums) {
               if($nums[$k] - $nums[$j] == $diff) {
                  $result++;
               }
            }
         }
      }
   }
   print "Output: $result\n";
}

