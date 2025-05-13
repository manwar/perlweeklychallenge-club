#!/bin/perl

=pod

The Weekly Challenge - 320
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-320#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Sum Difference
Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers.

Write a script to return the absolute difference between digit sum and
element sum of the given array.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub sumDifference (@ints) {
  my ($eSum,$dSum) = (0,0);
  for (@ints) {
    $eSum += $_;
    $dSum += $_ for (split//,$_);
  }
  return abs($eSum-$dSum);
}

is(18,sumDifference(1,23,4,5),'Example 1');
is(0,sumDifference(1,2,3,4,5),'Example 2');
is(27,sumDifference(1,2,34),'Example 3');

done_testing;
