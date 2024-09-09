#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-286/#TASK2
#
# Task 2: Order Game
# ==================
#
# You are given an array of integers, @ints, whose length is a power of 2.
#
# Write a script to play the order game (min and max) and return the last element.
#
## Example 1
##
## Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2)
## Output: 1
##
## Operation 1:
##
##     min(2, 1) = 1
##     max(4, 5) = 5
##     min(6, 3) = 3
##     max(0, 2) = 2
##
## Operation 2:
##
##     min(1, 5) = 1
##     max(3, 2) = 3
##
## Operation 3:
##
##     min(1, 3) = 1
#
## Example 2
##
## Input: @ints = (0, 5, 3, 2)
## Output: 0
##
## Operation 1:
##
##     min(0, 5) = 0
##     max(3, 2) = 3
##
## Operation 2:
##
##     min(0, 3) = 0
#
## Example 3
##
## Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
## Output: 2
##
## Operation 1:
##
##     min(9, 2) = 2
##     max(1, 4) = 4
##     min(5, 6) = 5
##     max(0, 7) = 7
##     min(3, 1) = 1
##     max(3, 5) = 5
##     min(7, 9) = 7
##     max(0, 8) = 8
##
## Operation 2:
##
##     min(2, 4) = 2
##     max(5, 7) = 7
##     min(1, 5) = 1
##     max(7, 8) = 8
##
## Operation 3:
##
##     min(2, 7) = 2
##     max(1, 8) = 8
##
## Operation 4:
##
##     min(2, 8) = 2
#
############################################################
##
## discussion
##
############################################################
#
# As long as @ints has more than one element, replace it with
# an array that contains the min/max of each pair of numbers,
# properly switching from min to max and vice versa on each
# step.

use strict;
use warnings;
use List::Util qw(min max);

order_game(2, 1, 4, 5, 6, 3, 0, 2);
order_game(0, 5, 3, 2);
order_game(9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8);

sub order_game {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   while(scalar(@ints) > 1) {
      @ints = min_max(@ints);
   }
   print "Output: $ints[0]\n";
}

sub min_max {
   my @ints = @_;
   my @result = ();
   my $which = 0;
   for (my $i = 0; $i < $#ints; $i+=2) {
      if($which) {
         $which = 0;
         push @result, max($ints[$i], $ints[$i+1]);
      } else {
         $which = 1;
         push @result, min($ints[$i], $ints[$i+1]);
      }
   }
   return @result;
}
