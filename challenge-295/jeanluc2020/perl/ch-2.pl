#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-295/#TASK2
#
# Task 2: Jump Game
# =================
#
# You are given an array of integers, @ints.
#
# Write a script to find the minimum number of jumps to reach the last element.
# $ints[$i] represents the maximum length of a forward jump from the index $i.
# In case last element is unreachable then return -1.
#
## Example 1
##
## Input: @ints = (2, 3, 1, 1, 4)
## Output: 2
##
## Jump 1 step from index 0 then 3 steps from index 1 to the last element.
#
## Example 2
##
## Input: @ints = (2, 3, 0, 4)
## Output: 2
#
## Example 3
##
## Input: @ints = (2, 0, 0, 4)
## Output: -1
#
############################################################
##
## discussion
##
############################################################
#
# We call a recursive function that carries the current index inside
# the array and the array itself. If the index is still inside the
# bounds of the array:
# - return 0 if the index points to the last element in the array
# - return undef if the index is out of bounds
# - otherwise call the function recursively for all possible jumps
#   from the current position; if any of those values exists, add
#   one to each of those and return the minimum value of all those
#   values.

use strict;
use warnings;
use List::Util qw(min);

jump_game(2, 3, 1, 1, 4);
jump_game(2, 3, 0, 4);
jump_game(2, 0, 0, 4);

sub jump_game {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $result = jump_game_(0, @ints);
   if(defined($result)) {
      print "Output: $result\n";
   } else {
      print "Output: -1\n";
   }
}

sub jump_game_ {
   my ($index, @ints) = @_;
   return 0 if $index == $#ints;
   return undef if $index > $#ints;
   return undef if $ints[$index] <= 0;
   my @possible_values = ();
   foreach my $i (1..$ints[$index]) {
      my $v = jump_game_($index + $i, @ints);
      if(defined($v)) {
         push @possible_values, 1+$v;
      }
   }
   return undef unless @possible_values;
   return min(@possible_values);
}

