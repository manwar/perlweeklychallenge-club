#!/bin/perl

=pod

The Weekly Challenge - 228
- https://theweeklychallenge.org/blog/perl-weekly-challenge-228

Author: Niels 'PerlBoy' van Dijke

Task 1: Unique Sum
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the sum of unique elements in the given array.

=cut

use v5.16;

use common::sense;

use Test::More;

use List::Util qw(sum0);
use List::MoreUtils qw(frequency);

sub uniqueSum (@) {
  my %f = frequency @_;
  return sum0 grep { $f{$_} == 1 } keys %f;
}

is(uniqueSum(2,1,3,2),4);
is(uniqueSum(1,1,1,1),0);
is(uniqueSum(2,1,3,4),10);

done_testing;
