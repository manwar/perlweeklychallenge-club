#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-269/#TASK1
#
# Task 1: Bitwise OR
# ==================
#
# You are given an array of positive integers, @ints.
#
# Write a script to find out if it is possible to select two or more elements
# of the given array such that the bitwise OR of the selected elements has
# atlest one trailing zero in its binary representation.
#
## Example 1
##
## Input: @ints = (1, 2, 3, 4, 5)
## Output: true
##
## Say, we pick 2 and 4, thier bitwise OR is 6. The binary representation of 6 is 110.
## Return true since we have one trailing zero.
#
## Example 2
##
## Input: @ints = (2, 3, 8, 16)
## Output: true
##
## Say, we pick 2 and 8, thier bitwise OR is 10. The binary representation of 10 is 1010.
## Return true since we have one trailing zero.
#
## Example 3
##
## Input: @ints = (1, 2, 5, 7, 9)
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# The bitwise OR of two or more numbers has a trailing 0 if all numbers
# have a trailing 0. This is the case if these numbers are even. So the
# problem boils down to the question whether or not the array has at least
# two even numbers.

use strict;
use warnings;

bitwise_or(1, 2, 3, 4, 5);
bitwise_or(2, 3, 8, 16);
bitwise_or(1, 2, 5, 7, 9);

sub bitwise_or {
   my @ints = @_;
   my $found_even = 0;
   print "Input: (", join(", ", @ints), ")\n";
   foreach my $int (@ints) {
      $found_even++ unless $int % 2;
   }
   if($found_even >= 2) {
      print "Output: true\n";
   } else {
      print "Output: false\n";
   }
}
