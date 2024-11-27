#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-296/#TASK2
#
# Task 2: Matchstick Square
# =========================
#
# You are given an array of integers, @ints.
#
# Write a script to find if it is possible to make one square using the sticks
# as in the given array @ints where $ints[ì] is the length of ith stick.
#
## Example 1
##
## Input: @ints = (1, 2, 2, 2, 1)
## Output: true
##
## Top: $ints[1] = 2
## Bottom: $ints[2] = 2
## Left: $ints[3] = 2
## Right: $ints[0] and $ints[4] = 2
#
## Example 2
##
## Input: @ints = (2, 2, 2, 4)
## Output: false
#
## Example 3
##
## Input: @ints = (2, 2, 2, 2, 4)
## Output: false
#
## Example 4
##
## Input: @ints = (3, 4, 1, 4, 3, 1)
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# First, we calculate the sum of all elements in the array. If that
# isn't divisible by 4, we can return false right away. Otherwise, we
# divide it by 4. Then we produce all permutations of the array
# (Algorithm::Combinatorics has a nice iterator for that). If it is
# possible to make a square from the matches, one at least one permutation of
# the array will be lined up such that subsequent numbers sum up to one
# fourth of the overall sum, so we will look out for such a case. If we
# find it, just return true. If we don't, then at the end after producing
# all possible permutations, we can return false.

use strict;
use warnings;
use List::Util qw(sum0);
use Algorithm::Combinatorics qw(permutations);

matchstick_square(1, 2, 2, 2, 1);
matchstick_square(2, 2, 2, 4);
matchstick_square(2, 2, 2, 2, 4);
matchstick_square(3, 4, 1, 4, 3, 1);
matchstick_square(4, 3, 3, 2, 2, 2, 2, 2, 2, 2);
matchstick_square(4, 3, 3, 2, 2, 2, 2, 2, 2);

sub matchstick_square {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $sum = sum0(@ints);
   if($sum % 4) {
      return print("Output: false\n");
   }
   $sum /= 4;
   my $iter = permutations(\@ints);
   OUTER: while(my $p = $iter->next) {
      my $s = 0;
      foreach my $elem (@$p) {
         $s += $elem;
         if($s > $sum) {
            next OUTER;
         }
         if($s == $sum) {
            $s = 0;
         }
      }
      if($s == 0) {
         return print "Output: true\n";
      }
   }
   print "Output: false\n";
}
