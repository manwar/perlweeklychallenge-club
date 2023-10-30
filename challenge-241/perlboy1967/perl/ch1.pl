#!/bin/perl

=pod

The Weekly Challenge - 241
- https://theweeklychallenge.org/blog/perl-weekly-challenge-241

Author: Niels 'PerlBoy' van Dijke

Task 1: Arithmetic Triplets
Submitted by: Mohammad S Anwar

You are given an array (3 or more members) of integers in increasing order and a positive integer.

Write a script to find out the number of unique Arithmetic Triplets satisfying the following rules:

a) i < j < k
b) nums[j] - nums[i] == diff
c) nums[k] - nums[j] == diff

=cut

use v5.32;
use common::sense;

use Test2::V0;

sub nArithmeticTriplets (\@$) {
  my ($arL,$diff) = @_;
  my $n = 0;

  for my $i (0 .. $arL->$#* - 2) {
    for my $j ($i + 1 .. $arL->$#* - 1) {
      for my $k ($j + 1 .. $arL->$#*) {
        $n++ if ($$arL[$j] - $$arL[$i] == $diff == $$arL[$k] - $$arL[$j]);
      }
    }
  }

  return $n;
}

is(nArithmeticTriplets(@{[0,1,4,6,7,10]},3), 2);
is(nArithmeticTriplets(@{[4,5,6,7,8,9]},2), 2);

done_testing;
