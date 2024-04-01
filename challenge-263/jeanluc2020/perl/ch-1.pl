#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/#TASK1
#
# Task 1: Target Index
# ====================
#
# You are given an array of integers, @ints and a target element $k.
#
# Write a script to return the list of indices in the sorted array where the
# element is same as the given target element.
#
## Example 1
##
## Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
## Output: (1, 2)
##
## Sorted array: (1, 2, 2, 3, 4, 5)
## Target indices: (1, 2) as $ints[1] = 2 and $k[2] = 2
#
## Example 2
##
## Input: @ints = (1, 2, 4, 3, 5), $k = 6
## Output: ()
##
## No element in the given array matching the given target.
#
## Example 3
##
## Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
## Output: (4)
##
## Sorted array: (1, 2, 2, 3, 4, 5)
## Target index: (4) as $ints[4] = 4
#
############################################################
##
## discussion
##
############################################################
#
# Straight forward steps: sort the input array, use an index to
# walk the array and remember the instances where $ints[$i] == $k.

use strict;
use warnings;

target_index( [1, 5, 3, 2, 4, 2], 2);
target_index( [1, 2, 4, 3, 5], 6);
target_index( [5, 3, 2, 4, 2, 1], 4);

sub target_index {
   my ($ints, $k) = @_;
   print "Input: (" . join(", ", @$ints) . ")\n";
   my @result = ();
   my @sorted = sort @$ints;
   foreach my $i (0..$#sorted) {
      if($sorted[$i] == $k) {
         push @result, $i;
      }
   }
   print "Output: (" . join(", ", @result) . ")\n";
}
