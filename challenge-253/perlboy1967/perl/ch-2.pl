#!/bin/perl

=pod

The Weekly Challenge - 253
- https://theweeklychallenge.org/blog/perl-weekly-challenge-253

Author: Niels 'PerlBoy' van Dijke

Task 2: Weakest Row
Submitted by: Mohammad S Anwar

You are given an m x n binary matrix i.e. only 0 and 1 where 1 always appear before 0.

A row i is weaker than a row j if one of the following is true:

|| a) The number of 1s in row i is less than the number of 1s in row j.
|| b) Both rows have the same number of 1 and i < j.

Write a script to return the order of rows from weakest to strongest.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::Util qw(sum0);

sub weakestRow ($ar) {
  my $i = 0;
  my @s = map { [$i++,sum0 @$_] } @$ar;
  map { $$_[0] } sort { $$a[1] <=> $$b[1] or $$a[0] <=> $$b[0] } @s;
}

is([weakestRow([
  [1, 1, 0, 0, 0],
  [1, 1, 1, 1, 0],
  [1, 0, 0, 0, 0],
  [1, 1, 0, 0, 0],
  [1, 1, 1, 1, 1]])],[2,0,3,1,4]);
is([weakestRow([
  [1, 0, 0, 0],
  [1, 1, 1, 1],
  [1, 0, 0, 0],
  [1, 0, 0, 0]])], [0,2,3,1]);

done_testing;
