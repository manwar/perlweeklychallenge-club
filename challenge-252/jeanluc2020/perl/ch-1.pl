#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-252/#TASK1
#
# Task 1: Special Numbers
# =======================
#
# You are given an array of integers, @ints.
#
# Write a script to find the sum of the squares of all special elements of the
# given array.
#
## An element $int[i] of @ints is called special if i divides n, i.e. n % i == 0.
## Where n is the length of the given array. Also the array is 1-indexed for the task.
#
## Example 1
##
## Input: @ints = (1, 2, 3, 4)
## Output: 21
##
## There are exactly 3 special elements in the given array:
## $ints[1] since 1 divides 4,
## $ints[2] since 2 divides 4, and
## $ints[4] since 4 divides 4.
##
## Hence, the sum of the squares of all special elements of given array:
## 1 * 1 + 2 * 2 + 4 * 4 = 21.
#
## Example 2
##
## Input: @ints = (2, 7, 1, 19, 18, 3)
## Output: 63
##
## There are exactly 4 special elements in the given array:
## $ints[1] since 1 divides 6,
## $ints[2] since 2 divides 6,
## $ints[3] since 3 divides 6, and
## $ints[6] since 6 divides 6.
##
## Hence, the sum of the squares of all special elements of given array:
## 2 * 2 + 7 * 7 + 1 * 1 + 3 * 3 = 63
#
############################################################
##
## discussion
##
############################################################
#
# We initialize a variable $result = 0, then we look at each
# element in the list and add its square to $result if $i divides n.

use strict;
use warnings;

special_numbers(1, 2, 3, 4);
special_numbers(2, 7, 1, 19, 18, 3);

sub special_numbers {
   my @ints = @_;
   print "Input: (", join(", ", @ints), ")\n";
   my $n = @ints;
   my $result = 0;
   foreach my $i (1..$n) {
      my $elem = $ints[$i-1];
      if($n % $i == 0) {
         $result += $elem*$elem;
      }
   }
   print "Output: $result\n";
}
