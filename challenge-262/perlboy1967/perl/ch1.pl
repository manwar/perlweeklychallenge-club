#!/bin/perl

=pod

The Weekly Challenge - 262
- https://theweeklychallenge.org/blog/perl-weekly-challenge-262

Author: Niels 'PerlBoy' van Dijke

Task 1: Max Positive Negative
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the maximum number of either positive or
negative integers in the given array.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(max);

sub maxPositiveNegative (@ints) {
  my @m = (0,0);

  for (@ints) {
    $m[0]++ if ($_ > 0);
    $m[1]++ if ($_ < 0);
  }

  return max(@m);
}

is(maxPositiveNegative(-3, 1, 2, -1, 3, -2, 4),4);
is(maxPositiveNegative(-1,-2,-3,1),3);
is(maxPositiveNegative(1,2),2);
is(maxPositiveNegative(-1,0,1),1);

done_testing;
