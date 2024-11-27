#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-293#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Boomerang
Submitted by: Mohammad Sajid Anwar

You are given an array of points, (x, y).

Write a script to find out if the given points are a boomerang.

|| A boomerang is a set of three points that are all distinct and not in
|| a straight line.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

use boolean;
use List::MoreUtils qw(uniq);

no warnings qw(experimental::signatures);
sub isBoomerang ($arPts) {
  # A boomerang needs three unique points
  return false if (uniq(map {"$$_[0]:$$_[1]"} @$arPts) != 3);

  # The three points should be collinear
  return false if (
    (($arPts->[1][1] - $arPts->[0][1]) * ($arPts->[2][0] - $arPts->[1][0])) ==
    (($arPts->[2][1] - $arPts->[1][1]) * ($arPts->[1][0] - $arPts->[0][0]))
  );

  return true;
}

is(true ,isBoomerang([[1,1],[2,3],[3,2]]),'Example 1');
is(false,isBoomerang([[1,1],[2,2],[3,3]]),'Example 2');
is(true ,isBoomerang([[1,1],[1,2],[2,3]]),'Example 3');
is(false,isBoomerang([[1,1],[1,2],[1,3]]),'Example 4');
is(false,isBoomerang([[1,1],[2,1],[3,1]]),'Example 5');
is(true ,isBoomerang([[0,0],[2,3],[4,5]]),'Example 6');

done_testing;

