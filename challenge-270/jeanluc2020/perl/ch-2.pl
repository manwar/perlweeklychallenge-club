#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-270/#TASK2
#
# Task 2: Distribute Elements
# ===========================
#
# You are give an array of integers, @ints and two integers, $x and $y.
#
# Write a script to execute one of the two options:
#
## Level 1:
## Pick an index i of the given array and do $ints[i] += 1
##
## Level 2:
## Pick two different indices i,j and do $ints[i] +=1 and $ints[j] += 1.
#
# You are allowed to perform as many levels as you want to make every elements
# in the given array equal. There is cost attach for each level, for Level 1,
# the cost is $x and $y for Level 2.
#
# In the end return the minimum cost to get the work done.
#
## Example 1
##
## Input: @ints = (4, 1), $x = 3 and $y = 2
## Output: 9
##
## Level 1: i=1, so $ints[1] += 1.
## @ints = (4, 2)
##
## Level 1: i=1, so $ints[1] += 1.
## @ints = (4, 3)
##
## Level 1: i=1, so $ints[1] += 1.
## @ints = (4, 4)
##
## We perforned operation Level 1, 3 times.
## So the total cost would be 3 x $x => 3 x 3 => 9
#
## Example 2
##
## Input: @ints = (2, 3, 3, 3, 5), $x = 2 and $y = 1
## Output: 6
##
## Level 2: i=0, j=1, so $ints[0] += 1 and $ints[1] += 1
## @ints = (3, 4, 3, 3, 5)
##
## Level 2: i=0, j=2, so $ints[0] += 1 and $ints[2] += 1
## @ints = (4, 4, 4, 3, 5)
##
## Level 2: i=0, j=3, so $ints[0] += 1 and $ints[3] += 1
## @ints = (5, 4, 4, 4, 5)
##
## Level 2: i=1, j=2, so $ints[1] += 1 and $ints[2] += 1
## @ints = (5, 5, 5, 4, 5)
##
## Level 1: i=3, so $ints[3] += 1
## @ints = (5, 5, 5, 5, 5)
##
## We perforned operation Level 1, 1 time and Level 2, 4 times.
## So the total cost would be (1 x $x) + (3 x $y) => (1 x 2) + (4 x 1) => 6
#
############################################################
##
## discussion
##
############################################################
#
# We find the index of the biggest number in the array, and the
# indices of the two smallest ones. As long as the smallest number
# is still smaller than the biggest one, we check:
# - if the second smallest number is still smaller than the biggest
#   AND the cost of incrementing two numbers is less than twice the
#   cost of incrementing one number, increment the two smallest
#   numbers
# - else increment the smallest number
#
# Two helper functions are used: max_at() returns the index of the
# biggest number in the array, min_at() returns the indices of the
# two smallest numbers in the array (first one wins if two numbers have
# the same value)

use strict;
use warnings;

distribute_elements( [4, 1], 3, 2);
distribute_elements( [2, 3, 3, 3, 5], 2, 1);

sub distribute_elements {
   my ($array, $x, $y) = @_;
   my @ints = @$array;
   print "Input: (", join(", ", @ints), "), \$x = $x, \$y = $y\n";
   my $result = 0;
   my $max_pos = max_at(@ints);
   my ($min1_pos, $min2_pos) = min_at(@ints);
   while($ints[$min1_pos] < $ints[$max_pos]) {
      if($ints[$min2_pos] < $ints[$max_pos] && 2*$x > $y) {
         $ints[$min2_pos]++;
         $ints[$min1_pos]++;
         $result += $y;
      } else {
         $ints[$min1_pos]++;
         $result += $x;
      }
      ($min1_pos, $min2_pos) = min_at(@ints);
   }
   print "Output: $result\n";
}

sub max_at {
   my @ints = @_;
   my $max_pos = 0;
   my $max = $ints[0];
   foreach my $i (1..$#ints) {
      if($ints[$i] > $max) {
         $max = $ints[$i];
         $max_pos = $i;
      }
   }
   return $max_pos;
}

sub min_at {
   my @ints = @_;
   my ($min1_pos, $min2_pos, $min1, $min2);
   if($ints[0] > $ints[1]) {
      $min1_pos = 1;
      $min2_pos = 0;
      $min1 = $ints[1];
      $min2 = $ints[0];
   } else {
      $min1_pos = 0;
      $min2_pos = 1;
      $min1 = $ints[0];
      $min2 = $ints[1];
   }
   foreach my $i (2..$#ints) {
      next unless $ints[$i] < $min2;
      if($ints[$i] < $min1) {
         ($min1, $min2) = ($ints[$i], $min1);
         ($min1_pos, $min2_pos) = ($i, $min1_pos);
      } else {
         $min2 = $ints[$i];
         $min2_pos = $i;
      }
   }
   return ($min1_pos, $min2_pos);
}

