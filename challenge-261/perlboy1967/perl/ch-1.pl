#!/bin/perl

=pod

The Weekly Challenge - 261
- https://theweeklychallenge.org/blog/perl-weekly-challenge-261

Author: Niels 'PerlBoy' van Dijke

Task 1: Element Digit Sum
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to evaluate the absolute difference between element
and digit sum of the given array.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(sum);

sub elementDigitSum (@ints) {
  sum(@ints) - sum(split //,join '',@ints);
}

is(elementDigitSum(1,2,3,45),36);
is(elementDigitSum(1,12,3),9);
is(elementDigitSum(1,2,3,4),0);
is(elementDigitSum(236,416,336,350),1296);

done_testing;
