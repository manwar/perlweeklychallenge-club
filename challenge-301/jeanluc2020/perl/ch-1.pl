#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-301/#TASK1
#
# Task 1: Largest Number
# ======================
#
# You are given a list of positive integers, @ints.
#
# Write a script to arrange all the elements in the given list such that they
# form the largest number and return it.
#
## Example 1
##
## Input: @ints = (20, 3)
## Output: 320
#
## Example 2
##
## Input: @ints = (3, 30, 34, 5, 9)
## Output: 9534330
#
############################################################
##
## discussion
##
############################################################
#
# Let's play dumb here, just create all possible permutations,
# create the number out of each permutation, then keep the maximum
# value.

use v5.40;
use Algorithm::Combinatorics qw(permutations);

largest_number(20, 3);
largest_number(3, 30, 34, 5, 9);

sub largest_number {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $max = join("", @ints);
   my $iter = permutations(\@ints);
   while(my $p = $iter->next) {
      my $t = join("", @$p);
      $max = $t if $t > $max;
   }
   print "Output: $max\n";
}

