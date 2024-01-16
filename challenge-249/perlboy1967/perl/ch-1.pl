#!/bin/perl

=pod

The Weekly Challenge - 249
- https://theweeklychallenge.org/blog/perl-weekly-challenge-249

Author: Niels 'PerlBoy' van Dijke

Task 1: Equal Pairs
Submitted by: Mohammad S Anwar

You are given an array of integers with even number of elements.

Write a script to divide the given array into equal pairs such that:

a) Each element belongs to exactly one pair.
b) The elements present in a pair are equal.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0;

use List::MoreUtils qw(frequency);

sub equalPairs (@ints) {
  my %f = frequency @ints;
  return [] if grep { $f{$_} % 2 } keys %f;
  [map { [$_,$_] } map { ($_) x ($f{$_}>>1) } sort {$a <=> $b} keys %f];
}

is(equalPairs(3,2,3,2,2,2),[[2,2],[2,2],[3,3]]);
is(equalPairs(1,2,3,4,),[]);

done_testing;
