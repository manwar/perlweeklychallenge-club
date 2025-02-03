#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-307/#TASK1
#
# Task 1: Check Order
# ===================
#
# You are given an array of integers, @ints.
#
# Write a script to re-arrange the given array in an increasing order and
# return the indices where it differs from the original array.
#
## Example 1
##
## Input: @ints = (5, 2, 4, 3, 1)
## Output: (0, 2, 3, 4)
##
## Before: (5, 2, 4, 3, 1)
## After : (1, 2, 3, 4, 5)
##
## Difference at indices: (0, 2, 3, 4)
#
## Example 2
##
## Input: @ints = (1, 2, 1, 1, 3)
## Output: (1, 3)
##
## Before: (1, 2, 1, 1, 3)
## After : (1, 1, 1, 2, 3)
##
## Difference at indices: (1, 3)
#
## Example 3
##
## Input: @ints = (3, 1, 3, 2, 3)
## Output: (0, 1, 3)
##
## Before: (3, 1, 3, 2, 3)
## After : (1, 2, 3, 3, 3)
##
## Difference at indices: (0, 1, 3)
#
############################################################
##
## discussion
##
############################################################
#
# Create the sorted array, then comapre the two arrays by index.
# Remember all positions where the two arrays differ.

use v5.36;

check_order(5, 2, 4, 3, 1);
check_order(1, 2, 1, 1, 3);
check_order(3, 1, 3, 2, 3);

sub check_order {
   my @ints = @_;
   say "Input: (" . join(", ", @ints) . ")";
   my @sorted = sort {$a<=>$b} @ints;
   my @result = ();
   foreach my $i (0..$#ints) {
      push @result, $i if $ints[$i] != $sorted[$i];
   }
   say "Output: (" . join(", ", @result) . ")";
}
