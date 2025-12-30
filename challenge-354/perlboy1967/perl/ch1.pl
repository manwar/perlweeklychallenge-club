#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-354#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Min Abs Diff
Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers.

Write a script to find all pairs of elements with the minimum absolute difference.

Rules (a,b):
1: a, b are from the given array.
2: a < b
3: b - a = min abs diff any two elements in the given array

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(min);
use List::MoreUtils qw(slide);

sub minAbsDiff (@ints) {
  my @i = sort { $a <=> $b } @ints;
  my %d;
  slide { push(@{$d{$b - $a}},[$a,$b]) } @i;
  return @{$d{min keys %d}};
}

is([minAbsDiff(4,2,1,3)],[[1,2],[2,3],[3,4]],'Example 1');
is([minAbsDiff(10,100,20,30)],[[10,20],[20,30]],'Example 2');
is([minAbsDiff(-5,-2,0,3)],[[-2,0]],'Example 3');
is([minAbsDiff(8,1,15,3)],[[1,3]],'Example 4');
is([minAbsDiff(12,5,9,1,15)],[[9,12],[12,15]],'Example 5');

done_testing;
