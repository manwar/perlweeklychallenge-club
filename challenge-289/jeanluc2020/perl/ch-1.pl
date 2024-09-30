#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-289/#TASK1
#
# Task 1: Third Maximum
# =====================
#
# You are given an array of integers, @ints.
#
# Write a script to find the third distinct maximum in the given array. If
# third maximum doesn’t exist then return the maximum number.
#
## Example 1
##
## Input: @ints = (5, 6, 4, 1)
## Output: 4
##
## The first distinct maximum is 6.
## The second distinct maximum is 5.
## The third distinct maximum is 4.
#
## Example 2
##
## Input: @ints = (4, 5)
## Output: 5
##
## In the given array, the third maximum doesn't exist therefore returns the maximum.
#
## Example 3
##
## Input: @ints =  (1, 2, 2, 3)
## Output: 1
##
## The first distinct maximum is 3.
## The second distinct maximum is 2.
## The third distinct maximum is 1.
#
############################################################
##
## discussion
##
############################################################
#
# We collect all distinct numbers as keys in a hash table. Then we
# sort these by size. In the end we keep the third maximum, if it
# is defined, otherwise the maximum.

use strict;
use warnings;

third_maximum(5, 6, 4, 1);
third_maximum(4, 5);
third_maximum(1, 2, 2, 3);

sub third_maximum {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $seen;
   map { $seen->{$_} = 1; } @ints;
   my @sorted_keys = sort { $b <=> $a } keys %$seen;
   my $result = $sorted_keys[2] // $sorted_keys[0];
   print "Output: $result\n";
}
