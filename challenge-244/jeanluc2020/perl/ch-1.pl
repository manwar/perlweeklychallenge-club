#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/#TASK1
#
# Task 1: Count Smaller
# =====================
#
# You are given an array of integers.
#
# Write a script to calculate the number of integers smaller than the integer
# at each index.
#
## Example 1
##
## Input: @int = (8, 1, 2, 2, 3)
## Output: (4, 0, 1, 1, 3)
##
## For index = 0, count of elements less 8 is 4.
## For index = 1, count of elements less 1 is 0.
## For index = 2, count of elements less 2 is 1.
## For index = 3, count of elements less 2 is 1.
## For index = 4, count of elements less 3 is 3.
#
## Example 2
##
## Input: @int = (6, 5, 4, 8)
## Output: (2, 1, 0, 3)
#
## Example 3
##
## Input: @int = (2, 2, 2)
## Output: (0, 0, 0)
#
############################################################
##
## discussion
##
############################################################
#
# Straight forward, for each element of the array, walk the whole array,
# checking each element for its size compared to the current one.

use strict;
use warnings;

count_smaller(8, 1, 2, 2, 3);
count_smaller(6, 5, 4, 8);
count_smaller(2, 2, 2);

sub count_smaller {
   my @int = @_;
   print "Input: (" . join(", ", @int) . ")\n";
   my @result = ();
   foreach my $elem (@int) {
      my $smaller = 0;
      foreach my $elem2 (@int) {
         $smaller++ if $elem2 < $elem;
      }
      push @result, $smaller;
   }
   print "Output: (" . join(", ", @result) . ")\n";
}

