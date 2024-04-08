#!/bin/perl

=pod

The Weekly Challenge - 262
- https://theweeklychallenge.org/blog/perl-weekly-challenge-262

Author: Niels 'PerlBoy' van Dijke

Task 2: Count Equal Divisible
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer $k.

Write a script to return the number of pairs (i, j) where

a) 0 <= i < j < size of @ints
b) ints[i] == ints[j]
c) i x j is divisible by k

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use Algorithm::Combinatorics qw(combinations);

sub countEqualDivisible ($k,@ints) {
  scalar grep {
    $ints[$$_[0]] == $ints[$$_[1]] and
    ($$_[0] * $$_[1]) % $k == 0;
  } combinations([0..$#ints],2);
}

is(countEqualDivisible(2,3,1,2,2,2,1,3),4);
is(countEqualDivisible(1,1,2,3),0);

done_testing;
