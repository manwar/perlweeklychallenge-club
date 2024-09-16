#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/#TASK1
#
# Task 1: Lucky Integer
# =====================
#
# You are given an array of integers, @ints.
#
# Write a script to find the lucky integer if found otherwise return -1. If
# there are more than one then return the largest.
#
### A lucky integer is an integer that has a frequency in the array equal to
### its value.
#
## Example 1
##
## Input: @ints = (2, 2, 3, 4)
## Output: 2
#
## Example 2
##
## Input: @ints = (1, 2, 2, 3, 3, 3)
## Output: 3
#
## Example 3
##
## Input: @ints = (1, 1, 1, 3)
## Output: -1
#
############################################################
##
## discussion
##
############################################################
#
# Count the frequencies for all elements in the array. Then
# check the frequencies versus the value sorted in descending
# order and stop once we find a match. If there was no match,
# return -1.

use strict;
use warnings;

lucky_integer(2, 2, 3, 4);
lucky_integer(1, 2, 2, 3, 3, 3);
lucky_integer(1, 1, 1, 3);

sub lucky_integer {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $frequencies = {};
   foreach my $i (@ints) {
      $frequencies->{$i}++;
   }
   foreach my $f (sort {$b<=>$a} keys %{$frequencies}) {
      return print "Output: $f\n" if $frequencies->{$f} == $f;
   }
   print "Output: -1\n";
}
