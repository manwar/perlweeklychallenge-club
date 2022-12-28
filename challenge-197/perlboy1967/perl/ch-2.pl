#!/bin/perl

=pod

The Weekly Challenge - 197
- https://theweeklychallenge.org/blog/perl-weekly-challenge-197/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Wiggle Sort
Submitted by: Mohammad S Anwar
You are given a list of integers, @list.

Write a script to perform Wiggle Sort on the given list.


Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]….

=cut

use v5.16;
use common::sense;

use Test::More;
use Test::Deep qw(cmp_deeply);

use List::MoreUtils qw(pairwise);


sub wiggleSort {
  my @lo = reverse sort { $a <=> $b } @_;
  my @up = splice(@lo, 0, scalar(@_) >> 1);
  return grep { defined } pairwise {$a,$b} @lo, @up;
}


for (
  [[1,5,1,1,6,4],[1,6,1,5,1,4]],
  [[1,3,2,2,3,1],[2,3,1,3,1,2]],
  [[1,2,3,4,5,6,7,8,9],[5,9,4,8,3,7,2,6,1]],
  [[8,12,10,11,9],[10,12,9,11,8]],
) {
  cmp_deeply([wiggleSort(@{$$_[0]})],$$_[1]);
}

done_testing;
