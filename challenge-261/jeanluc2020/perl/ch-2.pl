#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/#TASK2
#
# Task 2: Multiply by Two
# =======================
#
# You are given an array of integers, @ints and an integer $start.
#
# Write a script to do the followings:
#
# a) Look for $start in the array @ints, if found multiply the number by 2
# b) If not found stop the process otherwise repeat
#
# In the end return the final value.
#
## Example 1
##
## Input: @ints = (5,3,6,1,12) and $start = 3
## Output: 24
##
## Step 1: 3 is in the array so 3 x 2 = 6
## Step 2: 6 is in the array so 6 x 2 = 12
## Step 3: 12 is in the array so 12 x 2 = 24
##
## 24 is not found in the array so return 24.
#
## Example 2
##
## Input: @ints = (1,2,4,3) and $start = 1
## Output: 8
##
## Step 1: 1 is in the array so 1 x 2 = 2
## Step 2: 2 is in the array so 2 x 2 = 4
## Step 3: 4 is in the array so 4 x 2 = 8
##
## 8 is not found in the array so return 8.
#
## Example 3
##
## Input: @ints = (5,6,7) and $start = 2
## Output: 2
##
## 2 is not found in the array so return 2.
#
############################################################
##
## discussion
##
############################################################
#
# Instead of walking the list for every round, we create a
# hash with the list elements as keys, which makes the lookup
# easier. The we just check in a loop whether the current value
# is still there.

use strict;
use warnings;

multiply_by_two( [5,3,6,1,12], 3);
multiply_by_two( [1,2,4,3], 1);
multiply_by_two( [5,6,7], 2);

sub multiply_by_two {
   my ($ints, $start) = @_;
   print "Input: (", join(", ", @$ints), "), $start\n";
   my $hash;
   map { $hash->{$_} = 1; } @$ints;
   while($hash->{$start}) {
      $start *= 2;
   }
   print "Output: $start\n";
}
