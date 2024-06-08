#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/#TASK2
#
# Task 2: Number Game
# ===================
#
# You are given an array of integers, @ints, with even number of elements.
#
# Write a script to create a new array made up of elements of the given array.
# Pick the two smallest integers and add it to new array in decreasing order
# i.e. high to low. Keep doing until the given array is empty.
#
## Example 1
##
## Input: @ints = (2, 5, 3, 4)
## Output: (3, 2, 5, 4)
##
## Round 1: we picked (2, 3) and push it to the new array (3, 2)
## Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)
#
## Example 2
##
## Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
## Output: (1, 1, 4, 3, 6, 4, 9, 6)
#
## Example 3
##
## Input: @ints = (1, 2, 2, 3)
## Output: (2, 1, 3, 2)
#
############################################################
##
## discussion
##
############################################################
#
# First, we sort the input array. Then we pick the first two elements
# in reverse order until there are no more elements in the array.

use strict;
use warnings;

number_game(2, 5, 3, 4);
number_game(9, 4, 1, 3, 6, 4, 6, 1);
number_game(1, 2, 2, 3);

sub number_game {
   my @ints = @_;
   print "Input: (", join(", ", @ints), ")\n";
   my @sorted = sort { $a <=> $b } @ints;
   my @result = ();
   while(scalar(@sorted) >= 2) {
      my $first = shift @sorted;
      my $second = shift @sorted;
      push @result, ($second, $first);
   }
   print "Output: (", join(", ", @result), ")\n";
}

