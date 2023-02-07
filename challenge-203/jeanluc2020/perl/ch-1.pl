#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-203/#TASK1
#
# Task 1: Special Quadruplets
#
# You are given an array of integers.
#
# Write a script to find out the total special quadruplets for the given array.
#
## Special Quadruplets are such that satisfies the following 2 rules.
## 1) nums[a] + nums[b] + nums[c] == nums[d]
## 2) a < b < c < d
#
#
## Example 1
##
## Input: @nums = (1,2,3,6)
## Output: 1
##
## Since the only special quadruplets found is $nums[0] + $nums[1] + $nums[2] == $nums[3].
#
## Example 2
##
## Input: @nums = (1,1,1,3,5)
## Output: 4
##
## $nums[0] + $nums[1] + $nums[2] == $nums[3]
## $nums[0] + $nums[1] + $nums[3] == $nums[4]
## $nums[0] + $nums[2] + $nums[3] == $nums[4]
## $nums[1] + $nums[2] + $nums[3] == $nums[4]
#
## Example 3
##
## Input: @nums = (3,3,6,4,5)
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# this is pretty straight forward, just walk the array with 4 variables
# and in each step check the condition

use strict;
use warnings;
use feature 'say';

my @examples = (
   [1,2,3,6],
   [1,1,1,3,5],
   [3,3,6,4,5]
);

foreach my $nums (@examples) {
   say "Found " . get_quadruples(@$nums) . " for (" . join(", ", @$nums) . ")";
}

sub get_quadruples {
   my @nums = @_;
   my $count = 0;
   foreach my $A (0..$#nums) {
      foreach my $B ($A+1..$#nums) {
         foreach my $C ($B+1..$#nums) {
            foreach my $D ($C+1..$#nums) {
               $count++ if $nums[$A]+$nums[$B]+$nums[$C] == $nums[$D];
            }
         }
      }
   }
   return $count;
}
