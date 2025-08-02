#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-297/#TASK1
#
# Task 1: Contiguous Array
# ========================
#
# You are given an array of binary numbers, @binary.
#
# Write a script to return the maximum length of a contiguous subarray with an
# equal number of 0 and 1.
#
## Example 1
##
## Input: @binary = (1, 0)
## Output: 2
##
## (1, 0) is the longest contiguous subarray with an equal number of 0 and 1.
#
## Example 2
##
## Input: @binary = (0, 1, 0)
## Output: 2
##
## (1, 0) or (0, 1) is the longest contiguous subarray with an equal number of 0 and 1.
#
## Example 3
##
## Input: @binary = (0, 0, 0, 0, 0)
## Output: 0
#
## Example 4
##
## Input: @binary = (0, 1, 0, 0, 1, 0)
## Output: 4
#
############################################################
##
## discussion
##
############################################################
#
# For all possible sub-arrays of the input array, check whether
# the number of ones and zeroes is the same. If it is and the
# length of the subarray is bigger than the current maximum, set
# a new maximum. If the length of the sub-array is shorter than
# the current maximum, we can short-circuit the whole operation
# a little as well.

use strict;
use warnings;

contiguous_array(1, 0);
contiguous_array(0, 1, 0);
contiguous_array(0, 0, 0, 0, 0);
contiguous_array(0, 1, 0, 0, 1, 0);

sub contiguous_array {
   my @binary = @_;
   print "Input: (" . join(", ", @binary) . ")\n";
   my $max = 0;
   foreach my $i (0..$#binary) {
      foreach my $j ($i+1..$#binary) {
         my $len = $j + 1 - $i;
         next if $len < $max;
         my $zero = 0;
         my $one = 0;
         foreach my $k ($i..$j) {
            if($binary[$k] == 0) {
               $zero++;
            } else {
               $one++;
            }
         }
         if($zero == $one) {
            $max = $len;
         }
      }
   }
   print "Output: $max\n";
}
