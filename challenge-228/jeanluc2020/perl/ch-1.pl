#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-228/#TASK1
#
# Task 1: Unique Sum
# ==================
#
# You are given an array of integers.
#
# Write a script to find out the sum of unique elements in the given array.
#
## Example 1
##
## Input: @int = (2, 1, 3, 2)
## Output: 4
##
## In the given array we have 2 unique elements (1, 3).
#
## Example 2
##
## Input: @int = (1, 1, 1, 1)
## Output: 0
##
## In the given array no unique element found.
#
## Example 3
##
## Input: @int = (2, 1, 3, 4)
## Output: 10
##
## In the given array every element is unique.
#
############################################################
##
## discussion
##
############################################################
#
# For each Element in the array, count the number of occurences.
# Sum up the numbers where this number is 1.

use strict;
use warnings;

unique_sum(2, 1, 3, 2);
unique_sum(1, 1, 1, 1);
unique_sum(2, 1, 3, 4);

sub unique_sum {
   my @int = @_;
   print "Input: (" . join(", ", @int) . ")\n";
   my $count;
   # count the number of occurences for each element in the array
   map { $count->{$_}++; } @int;
   my $sum = 0;
   # sum up the ones that occured exacty once
   foreach my $key (keys %$count) {
      $sum += $key if $count->{$key} == 1;
   }
   print "Output: $sum\n";
}
