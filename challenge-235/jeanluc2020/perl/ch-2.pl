#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-235/#TASK2
#
# Task 2: Duplicate Zeros
# =======================
#
# You are given an array of integers.
#
# Write a script to duplicate each occurrence of ZERO in the given array and
# shift the remaining to the right but make sure the size of array remain the
# same.
#
## Example 1
##
## Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
## Ouput: (1, 0, 0, 2, 3, 0, 0, 4)
#
## Example 2
##
## Input: @ints = (1, 2, 3)
## Ouput: (1, 2, 3)
#
## Example 3
##
## Input: @ints = (0, 3, 0, 4, 5)
## Ouput: (0, 0, 3, 0, 0)
#
############################################################
##
## discussion
##
############################################################
#
# Let's start by noting that there might be a situation where the last element
# in the array is a 0 which can no longer be duplicated without changing the size
# of the array, so we won't duplicate in that case.

use strict;
use warnings;

duplicate_zeros(1, 0, 2, 3, 0, 4, 5, 0);
duplicate_zeros(1, 2, 3);
duplicate_zeros(0, 3, 0, 4, 5);
duplicate_zeros(0, 3, 0, 4);

sub duplicate_zeros {
   my @ints = @_;
   my @result = ();
   print "Input: (" . join(", ", @ints) . ")\n";
   while(@ints) {
      my $first = shift @ints;
      if(@ints) { # there are more elements in the array
         if($first == 0) {
            # duplicate the zero, remove last element from remainder
            # this will effectively "shift right" the remainder of the
            # array while keeping size
            pop(@ints);
            push @result, $first, 0;
         } else {
            # just move the non-zero value to the result
            push @result, $first;
         }
      } else { # no more elements in the array
         # this was the last element, so duplicating makes no sense any more
         # just add the element to the result in either case
         push @result, $first;
      }
   }
   print "Output: (" . join(", ", @result) . ")\n";
}
