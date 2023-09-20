#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-235/#TASK1
#
# Task 1: Remove One
# ==================
#
# You are given an array of integers.
#
# Write a script to find out if removing ONLY one integer makes it strictly
# increasing order.
#
## Example 1
##
## Input: @ints = (0, 2, 9, 4, 6)
## Output: true
##
## Removing ONLY 9 in the given array makes it strictly increasing order.
#
## Example 2
##
## Input: @ints = (5, 1, 3, 2)
## Output: false
#
## Example 3
##
## Input: @ints = (2, 2, 3)
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# Let's just remember that strictly increasing order means
# each element is bigger than the previous one and can't even
# be equal. So let's try to remove each element in turn and
# check if the remaining array is strictly increasing.

use strict;
use warnings;

remove_one(0, 2, 9, 4, 6);
remove_one(5, 1, 3, 2);
remove_one(2, 2, 3);

sub remove_one {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   foreach my $index (0..$#ints) {
      # if the remaining array with the element at the current index removed
      # is strictly increasing then we found a solution that works
      if(is_strictly_increasing(@ints[0..$index-1], @ints[$index+1..$#ints])) {
         print "Output: True\n";
         return;
      }
   }
   print "Output: False\n";
}

sub is_strictly_increasing {
   my @ints = @_;
   my $previous = shift @ints;
   # if any element is smaller or equal than the previous one, this
   # array is not strictly increasing
   foreach my $elem (@ints) {
      return 0 if $elem <= $previous;
      $previous = $elem;
   }
   return 1;
}
