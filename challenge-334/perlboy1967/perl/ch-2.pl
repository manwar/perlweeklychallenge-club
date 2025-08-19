#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-334#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Nearest Valid Point
Submitted by: Mohammad Sajid Anwar

You are given current location as two integers: x and y. You are also given
a list of points on the grid.

A point is considered valid if it shares either the same x-coordinate or the
same y-coordinate as the current location.

Write a script to return the index of the valid point that has the smallest 
Manhattan distance to the current location. If multiple valid points are tied
for the smallest distance, return the one with the lowest index. If no valid
points exist, return -1.

|| The Manhattan distance between two points (x1, y1) and (x2, y2) is calculated
|| as: |x1 - x2| + |y1 - y2|

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(min);
use List::MoreUtils qw(firstidx);

sub numberOfSmallestManhattanDistance ($x,$y,@points) {
  my $i = 0;
  my @p = map { [@$_, abs($x-$$_[0]) + abs($y-$$_[1])] } 
            grep { $$_[0] == $x or $$_[1] == $y }
              map { [@$_, $i++] } @points;
  return -1 unless @p;
  my @min = min(map { $$_[3] } @p);
  $p[firstidx { $$_[3] == $min[0] } @p][2];
}

is(numberOfSmallestManhattanDistance(3,4,[1,2],[3,1],[2,4],[2,3]),2,'Example 1');
is(numberOfSmallestManhattanDistance(2,5,[3,4],[2,3],[1,5],[2,5]),3,'Example 2');
is(numberOfSmallestManhattanDistance(1,1,[2,2],[3,3],[4,4]),-1,'Example 3');
is(numberOfSmallestManhattanDistance(0,0,[0,1],[1,0],[0,2],[2,0]),0,'Example 4');
is(numberOfSmallestManhattanDistance(5,5,[5,6],[6,5],[5,4],[4,5]),0,'Example 5');

done_testing;
