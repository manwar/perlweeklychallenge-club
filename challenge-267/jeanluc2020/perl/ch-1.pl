#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-267/#TASK1
#
# Task 1: Product Sign
# ====================
#
#
# You are given an array of @ints.
#
# Write a script to find the sign of product of all integers in the given
# array. The sign is 1 if the product is positive, -1 if the product is
# negative and 0 if product is zero.
#
## Example 1
##
## Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
## Output: 1
##
## The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0
#
## Example 2
##
## Input: @ints = (1, 2, 0, -2, -1)
## Output: 0
##
## The product 1 x 2 x 0 x -2 x -1 => 0
#
## Example 3
##
## Input: @ints = (-1, -1, 1, -1, 2)
## Output: -1
##
## The product -1 x -1 x 1 x -1 x 2 => -2 < 0
#
############################################################
##
## discussion
##
############################################################
#
# Multiply the integers one after another. If the result is 0,
# we can short-circuit the execution by returning 0 right away.
# After the loop, if the result is > 0, we can return 1, otherwise
# we return -1.

use strict;
use warnings;

product_sign(-1, -2, -3, -4, 3, 2, 1);
product_sign(1, 2, 0, -2, -1);
product_sign(-1, -1, 1, -1, 2);

sub product_sign {
   my @ints = @_;
   print "Input: (", join(", ", @ints), ")\n";
   my $p = 1;
   foreach my $i (@ints) {
      $p *= $i;
      if($p == 0) {
         print "Output: 0\n";
         return;
      }
   }
   if($p > 0) {
      print "Output: 1\n";
      return;
   }
   print "Output: -1\n";
}

