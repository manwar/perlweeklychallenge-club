#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/#TASK2
#
# Task 2: Digit Count Value
# =========================
#
# You are given an array of positive integers, @ints.
#
# Write a script to return true if for every index i in the range 0 <= i < size
# of array, the digit i occurs exactly the $ints[$i] times in the given array
# otherwise return false.
#
## Example 1
##
## Input: @ints = (1, 2, 1, 0)
## Ouput: true
##
## $ints[0] = 1, the digit 0 occurs exactly 1 time.
## $ints[1] = 2, the digit 1 occurs exactly 2 times.
## $ints[2] = 1, the digit 2 occurs exactly 1 time.
## $ints[3] = 0, the digit 3 occurs 0 time.
#
## Example 2
##
## Input: @ints = (0, 3, 0)
## Ouput: false
##
## $ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
## $ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
## $ints[2] = 0, the digit 2 occurs exactly 0 time.
#
############################################################
##
## discussion
##
############################################################
#
# This requires two passes:
# 1. count the digits
# 2. for each index of the array, check whether the digit count value
#    for this index matches the value in the array.

use strict;
use warnings;

digit_count_value(1, 2, 1, 0);
digit_count_value(0, 3, 0);

sub digit_count_value {
   my @ints = @_;
   my $digits_counts = {};
   print "Input: (" . join(", ", @ints) . ")\n";
   foreach my $digit (@ints) {
      $digits_counts->{$digit}++;
   }
   foreach my $i (0..$#ints) {
      $digits_counts->{$i} //= 0;
      return print "Output: false\n" unless $digits_counts->{$i} == $ints[$i];
   }
   return print "Output: true\n";
}
