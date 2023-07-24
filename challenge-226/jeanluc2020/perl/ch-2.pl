#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-226/#TASK2
#
# Task 2: Zero Array
# ==================
#
# You are given an array of non-negative integers, @ints.
#
# Write a script to return the minimum number of operations to make every
# element equal zero.
#
## In each operation, you are required to pick a positive number less than or
## equal to the smallest element in the array, then subtract that from each
## positive element in the array.
#
#
# Example 1:
#
# Input: @ints = (1, 5, 0, 3, 5)
# Output: 3
#
# operation 1: pick 1 => (0, 4, 0, 2, 4)
# operation 2: pick 2 => (0, 2, 0, 0, 2)
# operation 3: pick 2 => (0, 0, 0, 0, 0)
#
# Example 2:
#
# Input: @ints = (0)
# Output: 0
#
# Example 3:
#
# Input: @ints = (2, 1, 4, 0, 3)
# Output: 4
#
# operation 1: pick 1 => (1, 0, 3, 0, 2)
# operation 2: pick 1 => (0, 0, 2, 0, 1)
# operation 3: pick 1 => (0, 0, 1, 0, 0)
# operation 4: pick 1 => (0, 0, 0, 0, 0)
#
############################################################
##
## discussion
##
############################################################
#
# Comment:
# While the description says "pick a positive number less than or
# equal to the smallest element in the array", it is actually the
# smallest *positive* element in the array, or we could only pick
# "0" after the first element in the array is 0.
#
# Let's think a moment. If we pick any number that is less than
# the smallest positive number, we will have to pick another
# number again to get the smallest positive number to zero, so
# it's always best to use the smallest positive number to minimize
# the number of picks. Given this, it's simple to always pick the
# smallest positive number, substract it from all remaining
# positive numbers and be done.

use strict;
use warnings;

zero_array(1, 5, 0, 3, 5);
zero_array(0);
zero_array(2, 1, 4, 0, 3);

sub zero_array {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $steps = 0;
   while(non_zero(@ints)) {
      my $smallest_positive = smallest_positive(@ints);
      # substract the smallest positive number from each non-zero element
      @ints = map { $_ == 0 ? 0 : $_ - $smallest_positive; } @ints;
      $steps++;
   }
   print "Output: $steps\n";
}

# check if there are non-zero elements in an array
sub non_zero {
   my @ints = @_;
   foreach my $i (@ints) {
      return 1 if $i;
   }
   return 0;
}

# find the smallest positive number in an array
sub smallest_positive {
   my @ints = @_;
   my $smallest;
   foreach my $i (@ints) {
      if($i) {
         $smallest //= $i;
         $smallest = $i if $i < $smallest;
      }
   }
   # returns undef if there is no positive number in the array
   return $smallest;
}
