#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-291/#TASK1
#
# Task 1: Middle Index
# ====================
#
# You are given an array of integers, @ints.
#
# Write a script to find the leftmost middle index (MI) i.e. the smallest
# amongst all the possible ones.
#
## A middle index is an index where ints[0] + ints[1] + … + ints[MI-1] ==
##  ints[MI+1] + ints[MI+2] + … + ints[ints.length-1].
#
# If MI == 0, the left side sum is considered to be 0. Similarly,
# if MI == ints.length - 1, the right side sum is considered to be 0.
#
# Return the leftmost MI that satisfies the condition, or -1 if there is no
# such index.
#
## Example 1
##
## Input: @ints = (2, 3, -1, 8, 4)
## Output: 3
##
## The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
## The sum of the numbers after index 3 is: 4 = 4
#
## Example 2
##
## Input: @ints = (1, -1, 4)
## Output: 2
##
## The sum of the numbers before index 2 is: 1 + -1 = 0
## The sum of the numbers after index 2 is: 0
#
## Example 3
##
## Input: @ints = (2, 5)
## Output: -1
##
## There is no valid MI.
#
############################################################
##
## discussion
##
############################################################
#
# Starting at the beginning, we check the left and right side sum
# at each step. If they match, we return the index. If in the
# end, we didn't find the index, we return -1.

use strict;
use warnings;
use List::Util qw(sum);

middle_index(2, 3, -1, 8, 4);
middle_index(1, -1, 4);
middle_index(2, 5);

sub middle_index {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   foreach my $i (0..$#ints) {
      my $l = sum(@ints[0..$i-1]) // 0;
      my $r = sum(@ints[$i+1..$#ints]) // 0;
      if($r == $l) {
         return print "Output: $i\n";
      }
   }
   print "Output: -1\n";
}
