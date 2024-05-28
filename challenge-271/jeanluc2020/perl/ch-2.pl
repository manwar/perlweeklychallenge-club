#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-271/#TASK2
#
# Task 2: Sort by 1 bits
# ======================
#
# You are give an array of integers, @ints.
#
# Write a script to sort the integers in ascending order by the number of 1
# bits in their binary representation. In case more than one integers have the
# same number of 1 bits then sort them in ascending order.
#
## Example 1
##
## Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
## Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)
##
## 0 = 0 one bits
## 1 = 1 one bits
## 2 = 1 one bits
## 4 = 1 one bits
## 8 = 1 one bits
## 3 = 2 one bits
## 5 = 2 one bits
## 6 = 2 one bits
## 7 = 3 one bits
#
## Example 2
##
## Input: @ints = (1024, 512, 256, 128, 64)
## Output: (64, 128, 256, 512, 1024)
##
## All integers in the given array have one 1-bits, so just sort them in ascending order.
#
############################################################
##
## discussion
##
############################################################
#
# This one comes down to a slightly complex sort.
# We calculate the bit sum of a number (number of 1 bits) and sort
# by that - if the same, we sort by the numbers themselves.

use strict;
use warnings;

sort_by_one_bits(0, 1, 2, 3, 4, 5, 6, 7, 8);
sort_by_one_bits(1024, 512, 256, 128, 64);

sub sort_by_one_bits {
   my @ints = @_;
   print "Input: (", join(", ", @ints), ")\n";
   print "Output: (", join(", ", sort { bit_sum($a) <=> bit_sum($b) || $a <=> $b } @ints), ")\n";
}

sub bit_sum {
   my $i = shift;
   my $bits = sprintf("%b", $i);
   my $sum = 0;
   foreach my $bit (split //, $bits) {
      $sum += $bit;
   }
   return $sum;
}
