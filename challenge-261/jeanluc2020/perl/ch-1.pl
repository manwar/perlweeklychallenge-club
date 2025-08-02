#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/#TASK1
#
# Task 1: Element Digit Sum
# =========================
#
# You are given an array of integers, @ints.
#
# Write a script to evaluate the absolute difference between element and digit
# sum of the given array.
#
## Example 1
##
## Input: @ints = (1,2,3,45)
## Output: 36
##
## Element Sum: 1 + 2 + 3 + 45 = 51
## Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
## Absolute Difference: | 51 - 15 | = 36
#
## Example 2
##
## Input: @ints = (1,12,3)
## Output: 9
##
## Element Sum: 1 + 12 + 3 = 16
## Digit Sum: 1 + 1 + 2 + 3 = 7
## Absolute Difference: | 16 - 7 | = 9
#
## Example 3
##
## Input: @ints = (1,2,3,4)
## Output: 0
##
## Element Sum: 1 + 2 + 3 + 4 = 10
## Digit Sum: 1 + 2 + 3 + 4 = 10
## Absolute Difference: | 10 - 10 | = 0
#
## Example 4
##
## Input: @ints = (236, 416, 336, 350)
## Output: 1296
#
############################################################
##
## discussion
##
############################################################
#
# This is pretty straight forward, calculate the sum for each
# list, then calculate the digit sum by splitting each list
# element into its digits and then calculating the sum from there.

use strict;
use warnings;
use List::Util qw(sum);

element_digit_sum(1,2,3,45);
element_digit_sum(1,12,3);
element_digit_sum(1,2,3,4);
element_digit_sum(236, 416, 336, 350);

sub element_digit_sum {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $elem_sum = sum(@ints);
   my $digit_sum = 0;
   foreach my $elem (@ints) {
      $digit_sum += sum(split//, $elem);
   }
   print "Output: ", abs($elem_sum - $digit_sum), "\n";
}
