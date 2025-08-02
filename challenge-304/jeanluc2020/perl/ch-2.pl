#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-304/#TASK2
#
# Task 2: Maximum Average
# =======================
#
# You are given an array of integers, @ints and an integer, $n which is less
# than or equal to total elements in the given array.
#
# Write a script to find the contiguous subarray whose length is the given
# integer, $n, and has the maximum average. It should return the average.
#
## Example 1
##
## Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
## Output: 12.75
##
## Subarray: (12, -5, -6, 50)
## Average: (12 - 5 - 6 + 50) / 4 = 12.75
#
## Example 2
##
## Input: @ints = (5), $n = 1
## Output: 5
#
############################################################
##
## discussion
##
############################################################
#
# We calculate the average of the first n numbers. Then, using
# each element of the array as the starting point, we calculate
# the average starting at that point (skipping sub-arrays that
# aren't big enough at the end). Out of all of these averages,
# we keep the maximum.

use strict;
use warnings;
use List::Util qw(sum);

maximum_average(4, 1, 12, -5, -6, 50, 3);
maximum_average(1, 5);

sub maximum_average {
   my ($n, @ints) = @_;
   if($n > scalar(@ints) ) {
      return print "Error: not enough elements in list!\n";
   }
   print "Input: n=$n, \@ints=(" . join(", ", @ints) . ")\n";
   my $max = sum(@ints[0..$n-1]) / $n;
   foreach my $i (1..$#ints) {
      last if $i+$n-1 > $#ints;
      my $avg = sum(@ints[$i..$i+$n-1]) / $n;
      $max = $avg if $avg > $max;
   }
   print "Output: $max\n";
}
