#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-230/#TASK1
#
# Task 1: Separate Digits
# =======================
#
# You are given an array of positive integers.
#
# Write a script to separate the given array into single digits.
#
## Example 1
##
## Input: @ints = (1, 34, 5, 6)
## Output: (1, 3, 4, 5, 6)
#
## Example 2
##
## Input: @ints = (1, 24, 51, 60)
## Output: (1, 2, 4, 5, 1, 6, 0)
#
############################################################
##
## discussion
##
############################################################
#
# Just split the integers one by one and collect the result.

use strict;
use warnings;

separate_digits(1, 34, 5, 6);
separate_digits(1, 24, 51, 60);

sub separate_digits {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my @output = ();
   foreach my $i (@ints) {
      push @output, split //, $i;
   }
   print "Output: (" . join(", ", @output) . ")\n";
}
