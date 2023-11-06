#!/bin/perl

=pod

The Weekly Challenge - 242
- https://theweeklychallenge.org/blog/perl-weekly-challenge-242

Author: Niels 'PerlBoy' van Dijke

Task 2: Flip Matrix
Submitted by: Mohammad S Anwar

You are given n x n binary matrix.

Write a script to flip the given matrix.

=cut

use v5.32;
use common::sense;

use Test2::V0;

sub flipMatrix {
  [ map { [map { ++$_ % 2 } reverse @$_] } @_ ];
}

is(flipMatrix([1,1,0],[0,1,1],[0,0,1]),
             [[1,0,0],[0,0,1],[0,1,1]]);
is(flipMatrix([1,1,0,0],[1,0,0,1],[0,1,1,1],[1,0,1,0]),
             [[1,1,0,0],[0,1,1,0],[0,0,0,1],[1,0,1,0]]);

done_testing;
