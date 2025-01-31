#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-306/#TASK1
#
# Task 1: Odd Sum
# ===============
#
# You are given an array of positive integers, @ints.
#
# Write a script to return the sum of all possible odd-length subarrays of the
# given array. A subarray is a contiguous subsequence of the array.
#
## Example 1
##
## Input: @ints = (2, 5, 3, 6, 4)
## Output: 77
##
## Odd length sub-arrays:
## (2) => 2
## (5) => 5
## (3) => 3
## (6) => 6
## (4) => 4
## (2, 5, 3) => 10
## (5, 3, 6) => 14
## (3, 6, 4) => 13
## (2, 5, 3, 6, 4) => 20
##
## Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77
#
## Example 2
##
## Input: @ints = (1, 3)
## Output: 4
#
############################################################
##
## discussion
##
############################################################
#
# We walk the array from the first element to the last and
# add the sum of all subarrays starting at the current element
# when the number of elements in that subarray is odd.

use strict;
use warnings;
use List::Util qw(sum);

odd_sum(2, 5, 3, 6, 4);
odd_sum(1, 3);

sub odd_sum {
   my @ints = @_;
   print "Input: (" . join(",", @ints) . ")\n";
   my $sum = 0;
   foreach my $i (0..$#ints) {
      foreach my $j ($i..$#ints) {
         my @tmp = @ints[$i..$j];
         if(scalar(@tmp) % 2) {
            $sum += sum(@tmp);
         }
      }
   }
   print "Output: $sum\n";
}
