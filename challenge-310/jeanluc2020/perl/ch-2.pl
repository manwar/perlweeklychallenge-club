#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-310/#TASK2
#
# Task 2: Sort Odd Even
# =====================
#
# You are given an array of integers.
#
# Write a script to sort odd index elements in decreasing order and even index
# elements in increasing order in the given array.
#
## Example 1
##
## Input: @ints = (4, 1, 2, 3)
## Output: (2, 3, 4, 1)
##
## Even index elements: 4, 2 => 2, 4 (increasing order)
## Odd index elements : 1, 3 => 3, 1 (decreasing order)
#
## Example 2
##
## Input: @ints = (3, 1)
## Output: (3, 1)
#
## Example 3
##
## Input: @ints = (5, 3, 2, 1, 4)
## Output: (2, 3, 4, 1, 5)
##
## Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
## Odd index elements : 3, 1 => 3, 1 (decreasing order)
#
############################################################
##
## discussion
##
############################################################
#
# First, create two arrays, one for all the odd index elements and
# one for the even index elements. Then sort both of those lists
# in the desired order. Then mix the two arrays into the result array.

use v5.36;

sort_odd_even(4, 1, 2, 3);
sort_odd_even(3, 1);
sort_odd_even(5, 3, 2, 1, 4);

sub sort_odd_even(@ints) {
   say "Input: (" . join(", ", @ints) . ")";
   my @result;
   my @odd;
   my @even;
   foreach my $i (0..$#ints) {
      if($i % 2) {
         push @odd, $ints[$i];
      } else {
         push @even, $ints[$i];
      }
   }
   @odd = sort { $b <=> $a } @odd;
   @even = sort { $a <=> $b } @even;
   foreach my $i (0..$#even) {
      push @result, $even[$i];
      push @result, $odd[$i] if defined $odd[$i];
   }
   say "Output: (" . join(", ", @result) . ")";
}


