#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-240/#TASK2
#
# Task 2: Build Array
# ===================
#
# You are given an array of integers.
#
# Write a script to create an array such that new[i] = old[old[i]] where 0 <= i < new.length.
#
## Example 1
##
## Input: @int = (0, 2, 1, 5, 3, 4)
## Output: (0, 1, 2, 4, 5, 3)
#
## Example 2
##
## Input: @int = (5, 0, 1, 2, 3, 4)
## Output: (4, 5, 0, 1, 2, 3)
#
############################################################
##
## discussion
##
############################################################
#
# Just loop from 0 to the index of the last element and apply the rule

use strict;
use warnings;

build_array(0, 2, 1, 5, 3, 4);
build_array(5, 0, 1, 2, 3, 4);

sub build_array {
   my @int = @_;
   print "Input: (" . join(", ", @int) . ")\n";
   my @new = ();
   foreach my $i (0..$#int) {
      $new[$i] = $int[$int[$i]];
   }
   print "Output: (" . join(", ", @new) . ")\n";
}
