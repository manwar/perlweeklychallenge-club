#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-218/#TASK1
#
# Task 1: Maximum Product
# =======================
#
# You are given a list of 3 or more integers.
#
# Write a script to find the 3 integers whose product is the maximum and return it.
#
## Example 1
##
## Input: @list = (3, 1, 2)
## Output: 6
##
## 1 x 2 x 3 => 6
#
## Example 2
##
## Input: @list = (4, 1, 3, 2)
## Output: 24
##
## 2 x 3 x 4 => 24
#
## Example 3
##
## Input: @list = (-1, 0, 1, 3, 1)
## Output: 3
##
## 1 x 1 x 3 => 3
#
## Example 4
##
## Input: @list = (-8, 2, -9, 0, -4, 3)
## Output: 216
##
## -9 × -8 × 3 => 216
#
############################################################
##
## discussion
##
############################################################
#
# Using 3 index variables i, j, k we walk the list from
# beginning to end, calculate the product at the current
# 3 index positions, and then return the maximum

use strict;
use warnings;

maximum_product(3, 1, 2);
maximum_product(4, 1, 3, 2);
maximum_product(-1, 0, 1, 3, 1);
maximum_product(-8, 2, -9, 0, -4, 3);

sub maximum_product {
   my @list = @_;
   my $maximum;
   print "Input: (" . join(", ", @list) . ")\n";
   foreach my $i (0..$#list-2) {
      foreach my $j ($i+1..$#list-1) {
         foreach my $k ($j+1..$#list) {
            my $prod = $list[$i] * $list[$j] * $list[$k];
            $maximum //= $prod;
            $maximum = $prod if $prod > $maximum;
         }
      }
   }
   print "Output: $maximum\n";
}

