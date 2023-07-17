#!/bin/perl

=pod

The Weekly Challenge - 226
- https://theweeklychallenge.org/blog/perl-weekly-challenge-226

Author: Niels 'PerlBoy' van Dijke

Task 1: Shuffle String
Submitted by: Mohammad S Anwar

You are given a string and an array of indices of same length as string.

Write a script to return the string after re-arranging the indices in the correct order.

=cut

use v5.16;

use common::sense;

use Test::More;

sub shuffleString ($@) {
  my ($i,@c) = (0, split //, shift);
  my @o; map {$o[$_] = $c[$i++]} @_;
  return join '', @o;
}

is(shuffleString('lacelengh', 3,2,0,5,4,8,6,7,1),'challenge');
is(shuffleString('rulepark', 4,7,3,1,0,5,2,6),'perlraku');

done_testing;
