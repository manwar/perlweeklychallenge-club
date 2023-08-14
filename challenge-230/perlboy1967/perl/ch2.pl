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

sub countWords ($@) {
  my ($l,$p) = (length $_[0], shift);

  return scalar grep { substr($_,0,$l) eq $p } @_;
}

is(countWords('at', 'pay','attention','practice','attend'),2);
is(countWords('ja', 'janet','julia','java','javascript'),3);

done_testing;
