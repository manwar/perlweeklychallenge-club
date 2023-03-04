#!/bin/perl

=pod

The Weekly Challenge - 206
- https://theweeklychallenge.org/blog/perl-weekly-challenge-206

Author: Niels 'PerlBoy' van Dijke

Task 2: Array Pairings
Submitted by: Mohammad S Anwar

You are given an array of integers having even number of elements..

Write a script to find the maximum sum of the minimum of each pairs.

=cut

use v5.16;

use common::sense;

use Test::More;

sub arrayPairings (@) {
  return if scalar @_ % 2; 

  my ($s,$i) = (0,0);
  my @l = sort { $a <=> $b } @_;
  while ($i < scalar(@l)) {
    $s += $l[$i]; $i += 2;
  } 

  return $s;
}

is(undef,arrayPairings(qw(1)));
is(4,arrayPairings(qw(1 2 3 4)));
is(2,arrayPairings(qw(0 2 1 3)));
is(4,arrayPairings(qw(1 1 1 2 2 2)));
is(3,arrayPairings(qw(0 0 1 1 2 2)));

done_testing;

