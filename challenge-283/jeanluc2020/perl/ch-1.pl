#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/#TASK1
#
# Task 1: Unique Number
# =====================
#
# You are given an array of integers, @ints, where every elements appears more
# than once except one element.
#
# Write a script to find the one element that appears exactly one time.
#
## Example 1
##
## Input: @ints = (3, 3, 1)
## Output: 1
#
## Example 2
##
## Input: @ints = (3, 2, 4, 2, 4)
## Output: 3
#
## Example 3
##
## Input: @ints = (1)
## Output: 1
#
## Example 4
##
## Input: @ints = (4, 3, 1, 1, 1, 4)
## Output: 3
#
############################################################
##
## discussion
##
############################################################
#
# We first count how often each integer appears in the array, then
# we just return the first one that appears exactly once as a way
# to short-circuit that part of the execution.

use strict;
use warnings;

unique_number(3, 3, 1);
unique_number(3, 2, 4, 2, 4);
unique_number(1);
unique_number(4, 3, 1, 1, 1, 4);

sub unique_number {
   my @ints = @_;
   print "Input: (", join(", ", @ints), ")\n";
   my $found;
   foreach my $n (@ints) {
      $found->{$n}++;
   }
   foreach my $key (keys %$found) {
      return print "Output: $key\n" if $found->{$key} == 1;
   }
   return "Error: No number found exactly once!\n";
}
