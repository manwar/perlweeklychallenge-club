#!/bin/perl

=pod

The Weekly Challenge - 198
- https://theweeklychallenge.org/blog/perl-weekly-challenge-198/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Prime Count
Submitted by: Mohammad S Anwar

You are given an integer $n > 0.

Write a script to print the count of primes less than $n.

=cut

use v5.16;
use common::sense;

use Math::Prime::XS qw(primes);

use Test::More;


sub primeCount ($) {
  my @p = primes($_[0] - 1);
  return scalar @p;
}


is(primeCount(10),4);
is(primeCount(15),6);
is(primeCount(1),0);
is(primeCount(25),9);

done_testing;
