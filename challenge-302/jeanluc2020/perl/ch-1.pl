#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-302/#TASK1
#
# Task 1: Ones and Zeroes
# =======================
#
# You are given an array of binary strings, @str, and two integers, $x and $y.
#
# Write a script to return the size of the largest subset of @str such that
# there are at most $x 0’s and $y 1’s in the subset.
#
# A set m is a subset of n if all elements of m are also elements of n.
#
## Example 1
##
## Input: @str = ("10", "0001", "111001", "1", "0")
##        $x = 5
##        $y = 3
## Output: 4
##
## The largest subset with at most five 0's and three 1's:
## ("10", "0001", "1", "0")
#
## Example 2
##
## Input: @str = ("10", "1", "0")
##        $x = 1
##        $y = 1
## Output: 2
##
## The largest subset with at most one 0's and one 1's:
## ("1", "0")
#
############################################################
##
## discussion
##
############################################################
#
# We create all possible subsets. Then we check which ones fulfill the
# requirements regarding the number of ones and zeroes - of those we
# select the one that has the most elements.

use strict;
use warnings;
use Data::PowerSet qw(powerset);

one_and_zeroes(5, 3, "10", "0001", "111001", "1", "0");
one_and_zeroes(1, 1, "10", "1", "0");

sub one_and_zeroes {
   my ($x, $y, @str) = @_;
   print "Input: x = $x, y = $y, str = (\"" . join("\", \"", @str) . "\")\n";
   my $subsets = powerset(@str);
   my $max = 0;
   foreach my $subset (@$subsets) {
      my $count = scalar @$subset;
      my $ones = 0;
      my $zeroes = 0;
      foreach my $elem (@$subset) {
         my @digits = split //, $elem;
         foreach my $digit (@digits) {
            if($digit eq "1" ) {
               $ones++;
            } else {
               $zeroes++;
            }
         }
      }
      if($zeroes <= $x && $ones <= $y && $max < $count) {
         $max = $count;
      }
   }
   print "Output: $max\n";
}
