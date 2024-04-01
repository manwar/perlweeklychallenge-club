#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/#TASK2
#
# Task 2: Sum of Values
# =====================
#
# You are given an array of integers, @int and an integer $k.
#
# Write a script to find the sum of values whose index binary representation has
# exactly $k number of 1-bit set.
#
## Example 1
##
## Input: @ints = (2, 5, 9, 11, 3), $k = 1
## Output: 17
##
## Binary representation of index 0 = 0
## Binary representation of index 1 = 1
## Binary representation of index 2 = 10
## Binary representation of index 3 = 11
## Binary representation of index 4 = 100
##
## So the indices 1, 2 and 4 have total one 1-bit sets.
## Therefore the sum, $ints[1] + $ints[2] + $ints[3] = 17
#
## Example 2
##
## Input: @ints = (2, 5, 9, 11, 3), $k = 2
## Output: 11
#
## Example 3
##
## Input: @ints = (2, 5, 9, 11, 3), $k = 0
## Output: 2
#
############################################################
##
## discussion
##
############################################################
#
# For each element of the list:
# - calculate the number of 1-bit sets
# - compare to $k
# - return result of all ints[$i] where $i has $k 1-bits set

use strict;
use warnings;

sum_of_values([2, 5, 9, 11, 3], 1);
sum_of_values([2, 5, 9, 11, 3], 2);
sum_of_values([2, 5, 9, 11, 3], 0);

sub dec2bin {
   my $num = shift;
   return unpack("B32", pack("N", $num));
}

sub sum_of_values {
   my ($ints, $k) = @_;
   my @tmp = @$ints;
   print "Input: (", join(", ", @tmp), "), $k\n";
   my $result = 0;
   foreach my $index (0..$#tmp) {
      my $bin = dec2bin($index);
      my $bits_set = 0;
      foreach my $bit (split//, $bin) {
         if($bit eq "1") {
            $bits_set++;
         }
      }
      if($bits_set == $k) {
         $result += $tmp[$index];
      }
   }
   print "Output: $result\n";
}

