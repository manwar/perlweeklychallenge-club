#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-257/#TASK1
#
# Task 1: Smaller than Current
# ============================
#
# You are given a array of integers, @ints.
#
# Write a script to find out how many integers are smaller than current i.e.
# foreach ints[i], count ints[j] < ints[i] where i != j.
#
## Example 1
##
## Input: @ints = (5, 2, 1, 6)
## Output: (2, 1, 0, 3)
##
## For $ints[0] = 5, there are two integers (2,1) smaller than 5.
## For $ints[1] = 2, there is one integer (1) smaller than 2.
## For $ints[2] = 1, there is none integer smaller than 1.
## For $ints[3] = 6, there are three integers (5,2,1) smaller than 6.
#
## Example 2
##
## Input: @ints = (1, 2, 0, 3)
## Output: (1, 2, 0, 3)
#
## Example 3
##
## Input: @ints = (0, 1)
## Output: (0, 1)
#
## Example 4
##
## Input: @ints = (9, 4, 9, 2)
## Output: (2, 1, 2, 0)
#
############################################################
##
## discussion
##
############################################################
#
# Walk through the array, and for each element, walk through
# the whole array again, counting the elements that are smaller
# than the one in the outer loop. Put the result of this loop run
# at the end of the final result.
#
use strict;
use warnings;

smaller_than_current(5, 2, 1, 6);
smaller_than_current(1, 2, 0, 3);
smaller_than_current(0, 1);
smaller_than_current(9, 4, 9, 2);

sub smaller_than_current {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my @result = ();
   foreach my $i (0..$#ints) {
      my $count = 0;
      foreach my $j (0..$#ints) {
         next if $i == $j;
         $count++ if $ints[$i] > $ints[$j];
      }
      push @result, $count;
   }
   print "Output: (" . join(", ", @result) . ")\n";
}
