#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-234/#TASK2
#
# Task 2: Unequal Triplets
# ========================
#
# You are given an array of positive integers.
#
# Write a script to find the number of triplets (i, j, k) that satisfies
# num[i] != num[j], num[j] != num[k] and num[k] != num[i].
#
## Example 1
##
## Input: @ints = (4, 4, 2, 4, 3)
## Ouput: 3
##
## (0, 2, 4) because 4 != 2 != 3
## (1, 2, 4) because 4 != 2 != 3
## (2, 3, 4) because 2 != 4 != 3
#
## Example 2
##
## Input: @ints = (1, 1, 1, 1, 1)
## Ouput: 0
#
## Example 3
##
## Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
## Output: 28
##
## triplets of 1, 4, 7  = 3x2×2 = 12 combinations
## triplets of 1, 4, 10 = 3×2×1 = 6  combinations
## triplets of 4, 7, 10 = 2×2×1 = 4  combinations
## triplets of 1, 7, 10 = 3x2x1 = 6 combinations
#
############################################################
##
## discussion
##
############################################################
#
# We just walk the array from left to right 3 times inside of
# the previous loop and count the instances in which all 3
# numbers differ from each other

use strict;
use warnings;

unequal_triplets(4, 4, 2, 4, 3);
unequal_triplets(1, 1, 1, 1, 1);
unequal_triplets(4, 7, 1, 10, 7, 4, 1, 1);

sub unequal_triplets {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $result = 0;
   foreach my $i (0..$#ints) {
      foreach my $j ($i+1..$#ints) {
         foreach my $k ($j+1..$#ints) {
            if($ints[$i] != $ints[$j] && $ints[$j] != $ints[$k] && $ints[$i] != $ints[$k]) {
               $result++;
            }
         }
      }
   }
   print "Output: $result\n";
}

