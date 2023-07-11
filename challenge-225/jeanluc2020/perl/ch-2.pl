#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-225/#TASK2
#
# Task 2: Left Right Sum Diff
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers, @ints.
#
# Write a script to return left right sum diff array as shown below:
#
# @ints = (a, b, c, d, e)
#
# @left  = (0, a, (a+b), (a+b+c))
# @right = ((c+d+e), (d+e), e, 0)
# @left_right_sum_diff = ( | 0 - (c+d+e) |,
#                          | a - (d+e)   |,
#                          | (a+b) - e   |,
#                          | (a+b+c) - 0 | )
#
##
## WARNING: this explaination isn't entirely correct. As per
## https://leetcode.com/problems/left-and-right-sum-differences/
## it would make more sense to have an additional element
## (a+b+c+d) at the end of @left and ((b+c+d+e) at the beginning
## of @right, which also the examples demonstrate:
##
#
## Example 1:
##
## Input: @ints = (10, 4, 8, 3)
## Output: (15, 1, 11, 22)
##
## @left  = (0, 10, 14, 22)
## @right = (15, 11, 3, 0)
##
## @left_right_sum_diff = ( |0-15|, |10-11|, |14-3|, |22-0|)
##                      = (15, 1, 11, 22)
#
## Example 2:
##
## Input: @ints = (1)
## Output: (0)
##
## @left  = (0)
## @right = (0)
##
## @left_right_sum_diff = ( |0-0| ) = (0)
#
## Example 3:
##
## Input: @ints = (1, 2, 3, 4, 5)
## Output: (14, 11, 6, 1, 19)
##
## @left  = (0, 1, 3, 6, 10)
## @right = (14, 12, 9, 5, 0)
##
## @left_right_sum_diff = ( |0-14|, |1-12|, |3-9|, |6-5|, |10-0|)
##                      = (14, 11, 6, 1, 10)
#
############################################################
##
## discussion
##
############################################################
#
# First, calculate @left and @right, then calculate the
# @left_right_sum_diff

use strict;
use warnings;

left_right_sum_diff(10, 4, 8, 3);
left_right_sum_diff(1);
left_right_sum_diff(1, 2, 3, 4, 5);

sub left_right_sum_diff {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my ($current_left, $current_right) = (0, 0);
   my @left = ();
   my @right = ();
   foreach my $index (0..$#ints) {
      push @left, $current_left;
      $current_left += $ints[$index];
      unshift @right, $current_right;
      $current_right += $ints[ $#ints - $index ];
   }
   my @left_right_sum_diff = ();
   foreach my $index (0..$#ints) {
      $left_right_sum_diff[$index] = abs($left[$index] - $right[$index]);
   }
   print "Output: (" . join(", ", @left_right_sum_diff) . ")\n";
}
