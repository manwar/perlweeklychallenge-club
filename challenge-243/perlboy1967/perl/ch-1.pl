#!/bin/perl

=pod

The Weekly Challenge - 243
- https://theweeklychallenge.org/blog/perl-weekly-challenge-243

Author: Niels 'PerlBoy' van Dijke

Task 1: Reverse Pairs
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to return the number of reverse pairs in the given array.

A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].

=cut

use v5.32;
use common::sense;

use Test2::V0;

sub nReversePairs (@) {
  my $n = 0;

  for my $i (0 .. $#_ - 1) {
    for my $j ($i + 1 .. $#_) {
      $n++ if ($_[$i] > 2 * $_[$j]);
    }
  }

  return $n;
}

is(nReversePairs(1,3,2,3,1),2);
is(nReversePairs(2,4,3,5,1),3);

done_testing;
