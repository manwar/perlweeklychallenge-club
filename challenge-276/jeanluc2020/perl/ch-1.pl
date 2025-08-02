#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-276/#TASK1
#
# Task 1: Complete Day
# ====================
#
# You are given an array of integers, @hours.
#
# Write a script to return the number of pairs that forms a complete day.
#
### A complete day is defined as a time duration that is an exact multiple of
### 24 hours.
#
## Example 1
##
## Input: @hours = (12, 12, 30, 24, 24)
## Output: 2
##
## Pair 1: (12, 12)
## Pair 2: (24, 24)
#
## Example 2
##
## Input: @hours = (72, 48, 24, 5)
## Output: 3
##
## Pair 1: (72, 48)
## Pair 2: (72, 24)
## Pair 3: (48, 24)
#
## Example 3
##
## Input: @hours = (12, 18, 24)
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# Create all possible pairs and check which ones are multiples
# of 24.

use strict;
use warnings;

complete_day(12, 12, 30, 24, 24);
complete_day(72, 48, 24, 5);
complete_day(12, 18, 24);

sub complete_day {
   my @hours = @_;
   print "Input: (", join(", ", @hours), ")\n";
   my $output = 0;
   foreach my $i (0..$#hours) {
        foreach my $j ($i+1..$#hours) {
           $output++ unless (($hours[$i]+$hours[$j]) % 24);
        }
   }
   print "Output: $output\n";
}
