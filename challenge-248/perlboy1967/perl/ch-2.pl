#!/bin/perl

=pod

The Weekly Challenge - 248
- https://theweeklychallenge.org/blog/perl-weekly-challenge-248

Author: Niels 'PerlBoy' van Dijke

Task 2: Submatrix Sum
Submitted by: Jorg Sommrey

You are given a NxM matrix A of integers.

Write a script to construct a (N-1)x(M-1) matrix B having elements that are the
sum over the 2x2 submatrices of A,

b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0;

sub submatrixSum($arRef) {
  map {
    my $r = $_;
    [map { 
      $arRef->[$r][$_] +
      $arRef->[$r+1][$_] +
      $arRef->[$r][$_+1] +
      $arRef->[$r+1][$_+1]
    } 0 .. scalar(@{$arRef->[$r]}) - 2];
  } 0 .. scalar(@$arRef) - 2;
}

is([submatrixSum([
  [ 1, 2, 3, 4],
  [ 5, 6, 7, 8],
  [ 9,10,11,12],
])],[
  [14,18,22],
  [30,34,38],
]);

is([submatrixSum([
  [1,0,0,0],
  [0,1,0,0],
  [0,0,1,0],
  [0,0,0,1],
])],[
  [2,1,0],
  [1,2,1],
  [0,1,2],
]);

done_testing;
