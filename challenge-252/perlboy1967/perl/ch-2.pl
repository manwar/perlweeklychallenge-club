#!/bin/perl

=pod

The Weekly Challenge - 252
- https://theweeklychallenge.org/blog/perl-weekly-challenge-252

Author: Niels 'PerlBoy' van Dijke

Task 2: Unique Sum Zero
Submitted by: Mohammad S Anwar

You are given an integer, $n.

Write a script to find an array containing $n unique integers such that they add up to zero.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0;

sub uniqSumZero ($n) {
  my @n = (0);
  if ($n > 1) {
    @n = map { (-$_,$_) } 1 .. $n >> 1;
    push(@n,0) if ($n % 2 != 0);
  }
  [sort { $a <=> $b } @n];
}

is(uniqSumZero(1),[0]);
is(uniqSumZero(2),[-1,1]);
is(uniqSumZero(3),[-1,0,1]);
is(uniqSumZero(4),[-2,-1,1,2]);
is(uniqSumZero(5),[-2,-1,0,1,2]);

done_testing;
