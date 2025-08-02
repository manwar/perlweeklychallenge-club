#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-277/#TASK2
#
# Task 2: Strong Pair
# ===================
#
# You are given an array of integers, @ints.
#
# Write a script to return the count of all strong pairs in the given array.
#
### A pair of integers x and y is called strong pair if it satisfies:
### 0 < |x - y| < min(x, y).
#
## Example 1
##
## Input: @ints = (1, 2, 3, 4, 5)
## Ouput: 4
##
## Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)
#
## Example 2
##
## Input: @ints = (5, 7, 1, 7)
## Ouput: 1
##
## Strong Pairs: (5, 7)
#
############################################################
##
## discussion
##
############################################################
#
# We just walk the array from beginning to end for x and from
# the current position to the end for y, then check if the two
# numbers at those positions satisfy the condition for being a
# strong pair. However, we only count the strong pair if it hasn't
# occured earlier, as can be seen in example 2 (the task itself
# is unclear about this). It is also unclear whether strong pairs
# (a, b) and (b, a) are considered the same; so in my solution I
# consider those the same.
#

use strict;
use warnings;
use List::Util qw(min max);

strong_pair(1, 2, 3, 4, 5);
strong_pair(5, 7, 1, 7);

sub strong_pair {
   my @ints = @_;
   print "Input: (", join(", ", @ints), ")\n";
   my $seen = {};
   my $output = 0;
   foreach my $i (0..$#ints) {
      foreach my $j ($i+1..$#ints) {
         my $abs = abs($ints[$i] - $ints[$j]);
         my $min = min($ints[$i], $ints[$j]);
         my $max = max($ints[$i], $ints[$j]);
         next if $seen->{$min}->{$max};
         next if $abs == 0;
         next if $abs >= $min;
         $seen->{$min}->{$max} = 1;
         $output++;
      }
   }
   print "Output: $output\n";
}
