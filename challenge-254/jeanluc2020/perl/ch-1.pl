#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/#TASK1
#
# Task 1: Three Power
# ===================
#
# You are given a positive integer, $n.
#
# Write a script to return true if the given integer is a power of three
# otherwise return false.
#
## Example 1
##
## Input: $n = 27
## Output: true
##
## 27 = 3 ^ 3
#
## Example 2
##
## Input: $n = 0
## Output: true
##
## 0 = 0 ^ 3
#
## Example 3
##
## Input: $n = 6
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# Starting with $i at 0, count up to $n. If $i**3 == $n we have
# a third power, so return true. If $i**3 > $n we don't have a
# third power, so return false.
#
use strict;
use warnings;

three_power(27);
three_power(0);
three_power(6);

sub three_power {
   my $n = shift;
   print "Input: $n\n";
   foreach my $i (0..$n) {
      last if $i**3 > $n;
      if($i**3 == $n) {
         print "Output: true\n";
         return;
      }
   }
   print "Output: false\n";
}
