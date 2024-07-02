#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-276/#TASK2
#
# Task 2: Maximum Frequency
# =========================
#
# You are given an array of positive integers, @ints.
#
# Write a script to return the total number of elements in the given array
# which have the highest frequency.
#
## Example 1
##
## Input: @ints = (1, 2, 2, 4, 1, 5)
## Ouput: 4
##
## The maximum frequency is 2.
## The elements 1 and 2 has the maximum frequency.
#
## Example 2
##
## Input: @ints = (1, 2, 3, 4, 5)
## Ouput: 5
##
## The maximum frequency is 1.
## The elements 1, 2, 3, 4 and 5 has the maximum frequency.
#
############################################################
##
## discsussion
##
############################################################
#
# First, we calculate the frequencies for all numbers in the array.
# Then we sort that list by frequency and count all that share the
# maximum value.

use strict;
use warnings;

maximum_frequency(1, 2, 2, 4, 1, 5);
maximum_frequency(1, 2, 3, 4, 5);

sub maximum_frequency {
   my @ints = @_;
   my $freq = {};
   print "Input: (", join(", ", @ints), ")\n";
   foreach my $i (@ints) {
      $freq->{$i}++;
   }
   my $max = 0;
   my $output = 0;
   foreach my $i (sort { $freq->{$b} <=> $freq->{$a}} keys %$freq) {
      if($max < $freq->{$i}) {
         $max = $freq->{$i};
      }
      if($freq->{$i} == $max) {
         $output+=$max;
      }
   }
   print "Output: $output\n";
}
