#!/bin/perl

=pod 

The Weekly Challenge - 263
- https://theweeklychallenge.org/blog/perl-weekly-challenge-263

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

sub mergeItems ($arItems1,$arItems2) {
  my %o;
  for (@$arItems1,@$arItems2) {
    $o{$_->[0]} += $_->[1];
  }
  map { [$_,$o{$_}] } sort { $a <=> $b } keys %o;
}

is([mergeItems([[1,1],[2,1],[3,2]],
               [[2,2],[1,3]])],
   [[1,4],[2,3],[3,2]]);
is([mergeItems([[1,2],[2,3],[1,3],[3,2]],
               [[3,1],[1,3]])],
   [[1,8],[2,3],[3,3]]);
is([mergeItems([[1,1],[2,2],[3,3] ],
               [[2,3],[2,4]])],
   [[1,1],[2,9],[3,3]]);

done_testing;
