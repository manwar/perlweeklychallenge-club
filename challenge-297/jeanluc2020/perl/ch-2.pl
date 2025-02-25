#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-297/#TASK2
#
# Task 2: Semi-Ordered Permutation
# ================================
#
# You are given permutation of $n integers, @ints.
#
# Write a script to find the minimum number of swaps needed to make the @ints a
# semi-ordered permutation.
#
# A permutation is a sequence of integers from 1 to n of length n containing
# each number exactly once.
# A permutation is called semi-ordered if the first number is 1 and the last
# number equals n.
#
# You are ONLY allowed to pick adjacent elements and swap them.
#
## Example 1
##
## Input: @ints = (2, 1, 4, 3)
## Output: 2
##
## Swap 2 <=> 1 => (1, 2, 4, 3)
## Swap 4 <=> 3 => (1, 2, 3, 4)
#
## Example 2
##
## Input: @ints = (2, 4, 1, 3)
## Output: 3
##
## Swap 4 <=> 1 => (2, 1, 4, 3)
## Swap 2 <=> 1 => (1, 2, 4, 3)
## Swap 4 <=> 3 => (1, 2, 3, 4)
#
## Example 3
##
## Input: @ints = (1, 3, 2, 4, 5)
## Output: 0
##
## Already a semi-ordered permutation.
#
############################################################
##
## discussion
##
############################################################
#
# The number of swaps to get the "1" to the beginning of the array
# is equal to the index of the "1" inside the array. The number of
# swaps to get n to the end of the array is the index of the last
# element in the array minus the index of n in the array. The
# result is therefore the sum of those two numbers (minus 1 if
# in the beginning, the 1 is later in the array than n because one
# swap will swap the 1 and the n and would otherwise be counted
# twice).

use strict;
use warnings;

semi_ordered_permutation(2, 1, 4, 3);
semi_ordered_permutation(2, 4, 1, 3);
semi_ordered_permutation(1, 3, 2, 4, 5);

sub semi_ordered_permutation {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $index_of_1 = 0;
   my $index_of_n = 0;
   foreach my $i (0..$#ints) {
      if($ints[$i] == 1) {
         $index_of_1 = $i;
      }
      if($ints[$i] == scalar(@ints)) {
         $index_of_n = $i;
      }
   }
   my $result = 0;
   if($index_of_1 < $index_of_n) {
      $result = $index_of_1 + ($#ints - $index_of_n);
   } else {
      $result = $index_of_1 + ($#ints - $index_of_n - 1);
   }
   print "Output: $result\n";
}
