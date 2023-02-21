#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-205/#TASK2
#
# Maximum XOR
# ===========
#
# You are given an array of integers.
#
# Write a script to find the highest value obtained by XORing any two distinct members of the array.
#
## Example 1
##
## Input: @array = (1,2,3,4,5,6,7)
## Output: 7
##
## The maximum result of 1 xor 6 = 7.
#
## Example 2
##
## Input: @array = (2,4,1,3)
## Output: 7
##
## The maximum result of 4 xor 3 = 7.
#
## Example 3
##
## Input: @array = (10,5,7,12,8)
## Output: 15
##
## The maximum result of 10 xor 5 = 15.
#
############################################################
##
## discussion
##
############################################################
#
# We have to walk the array in two loops to get all combinations
# of elements, then we xor those elements and remember the
# maximum result.

use strict;
use warnings;

maximum_xor(1,2,3,4,5,6,7);
maximum_xor(2,4,1,3);
maximum_xor(10,5,7,12,8);
maximum_xor();
maximum_xor(1);

sub maximum_xor {
   my @array = @_;
   # just some error handling for when the array is too small
   if(@array < 2) {
      print "Not enough elements in array to calculate xor!\n";
      return;
   }
   print "Input: (" . join(", ", @array) . ")\n";
   # initialize the maximum with the xor of the first two elements
   my $max = ($array[0] ^ $array[1]);
   foreach my $i (0..$#array) {
      foreach my $j ($i+1..$#array) {
         my $now = ($array[$i] ^ $array[$j]);
         $max = $now if $now > $max;
      }
   }
   print "Output: $max\n";
}
