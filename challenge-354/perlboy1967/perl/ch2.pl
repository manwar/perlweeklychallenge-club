#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-354#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Shift Grid
Submitted by: Mohammad Sajid Anwar

You are given m x n matrix and an integer, $k > 0.

Write a script to shift the given matrix $k times.

Each shift follow the rules:

Rule 1:
Element at grid[i][j] moves to grid[i][j + 1]
This means every element moves one step to the right within its row.

Rule 2:
Element at grid[i][n - 1] moves to grid[i + 1][0]
This handles the last column: elements in the last column of row i wrap to 
the first column of the next row (i+1).

Rule 3:
Element at grid[m - 1][n - 1] moves to grid[0][0]
This is the bottom-right corner: it wraps to the top-left corner.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::MoreUtils qw(arrayify);

sub shiftGrid ($arGrid,$k) {
  my ($w,$h) = (scalar @{$arGrid->[0]}, scalar @$arGrid);
  return @$arGrid if $k % ($w * $h) == 0; # return original
  my @l = arrayify($arGrid);
  $k %= ($w * $h); # reduce k to sensible value
  @l = (@l[$#l - $k + 1 .. $#l],@l[0 .. $#l - $k]); # 'shift' grid
  map { [splice(@l,0,$w)] } (1 .. $h); # produce shifted grid
}

is([shiftGrid([[1,2,3],[4,5,6],[7,8,9]],1)],
              [[9,1,2],[3,4,5],[6,7,8]],'Example 1');
is([shiftGrid([[10,20],[30,40]],1)],
              [[40,10],[20,30]],'Example 2');
is([shiftGrid([[1,2],[3,4],[5,6]],1)],
              [[6,1],[2,3],[4,5]],'Example 3');
is([shiftGrid([[1,2,3],[4,5,6]],5)],
              [[2,3,4],[5,6,1]],'Example 4');
is([shiftGrid([[1,2,3,4]],1)],
              [[4,1,2,3]],'Example 5');
is([shiftGrid([[1,2],[3,4]],4)],
              [[1,2],[3,4]],'Own Example 1');
is([shiftGrid([[1,2],[3,4]],5)],
              [[4,1],[2,3]],'Own Example 2');

done_testing;

