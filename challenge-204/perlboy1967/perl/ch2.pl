#!/bin/perl

=pod

The Weekly Challenge - 204
- https://theweeklychallenge.org/blog/perl-weekly-challenge-204/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Reshape Matrix
Submitted by: Mohammad S Anwar

You are given a matrix (m x n) and two integers (r) and (c).

Write a script to reshape the given matrix in form (r x c) with the original value
in the given matrix. If you can’t reshape print 0.

=cut

use v5.16;
use common::sense;

use List::MoreUtils qw(arrayify);

use Test::More;
use Test::Deep qw(cmp_deeply);


sub reshapeMatrix ($$\@) {
  my ($r,$c,$ar) = @_;

  my @l = arrayify($ar);
  return [] if ($r * $c != scalar @l);

  $ar = [];
  while ($r--) {
    push($ar,[splice(@l,0,$c)]);
  }

  return $ar; 
}

cmp_deeply(reshapeMatrix(1,4,@{[[1,2],[3,4]]}),
           [[1,2,3,4]]);
cmp_deeply(reshapeMatrix(3,2,@{[[1,2,3],[4,5,6]]}),
           [[1,2],[3,4],[5,6]]);
cmp_deeply(reshapeMatrix(3,2,@{[[1,2]]}),
           []);

done_testing;
