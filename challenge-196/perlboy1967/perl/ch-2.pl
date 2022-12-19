#!/bin/perl

=pod

The Weekly Challenge - 196
- https://theweeklychallenge.org/blog/perl-weekly-challenge-195/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Range List
Submitted by: Mohammad S Anwar

You are given a sorted unique integer array, @array.

Write a script to find all possible Number Range i.e [x, y] represent range all integers from x and y (both inclusive).

||  Each subsequence of two or more contiguous integers

=cut

use v5.16;
use common::sense;

use List::MoreUtils qw(slide);

use Test::More;
use Test::Deep qw(cmp_deeply);

sub rangeList (@) {
  my @r = ([$_[0]]);

  slide { 
    if ($a == $b - 1) {
      push(@{$r[-1]},$b);
    } else {
      push(@r,[$b]);
    }
  } @_;

  [map { [$$_[0],$$_[-1]] } grep { scalar @$_ > 1 } @r];
}

for (
  [[1,3,4,5,7], [[3,5]]],
  [[1,2,3,6,7,9], [[1,3],[6,7]]],
  [[0,1,2,4,5,6,8,9], [[0,2],[4,6],[8,9]]],
) {
  cmp_deeply(rangeList(@{$_->[0]}),
             [@{$_->[1]}], 
             sprintf('test [%s]',join(',',@{$_->[0]})));
} 

done_testing;
