#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-338#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Highest Row
Submitted by: Mohammad Sajid Anwar

You are given a m x n matrix.

Write a script to find the highest row sum in the given matrix.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util (qw(max sum));

sub highestRow (@matrix) {
  max map { sum @$_ } @matrix; 
}

is(highestRow([4,4,4,4],[10,0,0,0],[2,2,2,9]),16,'Example 1');
is(highestRow([1,5],[7,3],[3,5]),10,'Example 2');
is(highestRow([1,2,3],[3,2,1]),6,'Example 3');
is(highestRow([2,8,7],[7,1,3],[1,9,5]),17,'Example 4');
is(highestRow([10,20,40],[5,5,5,],[0,100,0],[25,25,25]),100,'Example 5');

done_testing;
