#!/bin/perl

=pod

The Weekly Challenge - 230
- https://theweeklychallenge.org/blog/perl-weekly-challenge-230

Author: Niels 'PerlBoy' van Dijke

Task 1: Separate Digits
Submitted by: Mohammad S Anwar

You are given an array of positive integers.

Write a script to separate the given array into single digits.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep;

sub seperateDigits (@) {
  return map { split //,$_ } @_;
}

cmp_deeply([seperateDigits(1,34,5,6)],[1,3,4,5,6]);
cmp_deeply([seperateDigits(1,24,51,60)],[1,2,4,5,1,6,0]);

done_testing;
