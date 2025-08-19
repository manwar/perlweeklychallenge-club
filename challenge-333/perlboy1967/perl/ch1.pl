#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-333#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Straight Line
Submitted by: Mohammad Sajid Anwar

You are given a list of co-ordinates.

Write a script to find out if the given points make a straight line.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;
use List::MoreUtils qw(all uniq);

sub areInStraightLine (@p) {
  my @u = map { [split / /] } uniq map { $$_[0].' '.$$_[1] } @p ;
  return true if @u == 1 or @u == 2;

  my ($p1,$p2) = (shift @u, shift @u);
  my ($x1,$y1,$x2,$y2) = ($$p1[0],$$p1[1],$$p2[0],$$p2[1]);

  if ($x1 == $x2) {
    boolean(all { $$_[0] == $x1 } @u);
  } else {
    my $a = ($y2 - $y1) / ($x2 - $x1);
    my $b = $y1 - $a * $x1;
    boolean(all { $$_[1] == $a * $$_[0] + $b } @u);
  }
}

is(areInStraightLine([2,1],[2,3],[2,5]),true,'Example 1');
is(areInStraightLine([1,4],[3,4],[10,4]),true,'Example 2');
is(areInStraightLine([0,0],[1,1],[2,3]),false,'Example 3');
is(areInStraightLine([1,1],[1,1],[1,1]),true,'Example 4');
my $m = 1_000_000;
is(areInStraightLine([1*$m,1*$m],[2*$m,2*$m],[3*$m,3*$m]),true,'Example 5');

is(areInStraightLine([1,1],[1,1],[2,2]),true,'Own example 1');
is(areInStraightLine([1,1],[1,1],[2,2],[3,3]),true,'Own example 2');
is(areInStraightLine([1,1],[1,1],[2,2],[3,3],[4,5]),false,'Own example 3');

done_testing;
