#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-231/#TASK1
#
# Task 1: Min Max
# ===============
#
# You are given an array of distinct integers.
#
# Write a script to find all elements that is neither minimum nor maximum.
# Return -1 if you can’t.
#
## Example 1
##
## Input: @ints = (3, 2, 1, 4)
## Output: (3, 2)
##
## The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither
## min nor max.
#
## Example 2
##
## Input: @ints = (3, 1)
## Output: -1
#
## Example 3
##
## Input: @ints = (2, 1, 3)
## Output: (2)
##
## The minimum is 1 and maximum is 3 in the given array. So 2 is neither min
## nor max.
#
############################################################
##
## discussion
##
############################################################
#
# first, calculate the minimum and maximum of the elements
# in the array - we can do that in one pass. Then we collect
# all elements that are neither the minimum nor the maximum

use strict;
use warnings;

min_max(3, 2, 1, 4);
min_max(3, 1);
min_max(2, 1, 3);

sub min_max {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   if(@ints <= 2) {
      print "Output: -1\n";
      return;
   }
   my ($min, $max) = min_and_max(@ints);
   my @result = ();
   foreach my $elem (@ints) {
      next if $elem == $min;
      next if $elem == $max;
      push @result, $elem;
   }
   if(@result) {
      print "Output: (" . join(", ", @result) . ")\n";
      return;
   }
   print "Output: -1\n";
}

sub min_and_max {
   my @ints = @_;
   my $min = $ints[0];
   my $max = $ints[0];
   foreach my $elem (@ints) {
      $min = $elem if $elem < $min;
      $max = $elem if $elem > $max;
   }
   return ($min,$max);
}
