#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-337#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Odd Matrix
Submitted by: Mohammad Sajid Anwar

You are given row and col, also a list of positions in the matrix.

Write a script to perform action on each location (0-indexed) as provided in
the list and find out the total odd valued cells.

For each location (r, c), do both of the following:

a) Increment by 1 all the cells on row r.
b) Increment by 1 all the cells on column c.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(sum0);

sub oddMatrix ($row,$col,@locations) {
  my @m = map { [(0) x $col]  } (0 .. --$row);
  $col--;

  for (@locations) {
    my ($r,$c) = @$_;
    $m[$r][$_]++ for (0 .. $col);
    $m[$_][$c]++ for (0 .. $row);
  }

  sum0 map { scalar grep { $_ % 2 } @$_ } @m; 
}

is(oddMatrix(2,3,[0,1],[1,1]),6,'Example 1');
is(oddMatrix(2,2,[1,1],[0,0]),0,'Example 2');
is(oddMatrix(3,3,[0,0],[1,2],[2,1]),0,'Example 3');
is(oddMatrix(1,5,[0,2],[0,4]),2,'Example 4');

done_testing;
