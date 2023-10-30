#!/bin/perl

=pod

The Weekly Challenge - 235
- https://theweeklychallenge.org/blog/perl-weekly-challenge-235

Author: Niels 'PerlBoy' van Dijke

Task 2: Duplicate Zeros
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to duplicate each occurrence of ZERO in the given array and
shift the remaining to the right but make sure the size of array remain the same.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep qw(cmp_deeply);

sub duplicateZeros (@) {
  my @r;

  for (@_) {
    push(@r,$_);
    if ($r[-1] == 0) {
      push(@r,0); pop(@_)
    }
  }

  return @r;
}

cmp_deeply([duplicateZeros(1, 0, 2, 3, 0, 4, 5, 0)],
           [1, 0, 0, 2, 3, 0, 0, 4]);
cmp_deeply([duplicateZeros(1, 2 , 3)],
           [1, 2, 3]);
cmp_deeply([duplicateZeros(0, 3, 0, 4, 5)],
           [0, 0, 3, 0, 0]);

done_testing;

