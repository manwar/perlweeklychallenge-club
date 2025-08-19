#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-334#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Range Sum
Submitted by: Mohammad Sajid Anwar

You are given a list integers and pair of indices..

Write a script to return the sum of integers between the given indices (inclusive).

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(sum0);

sub rangeSum ($il,$ih,@ints) {
  return sum0(@ints[$il..$ih]);
}

is(rangeSum(0,2,-2,0,3,-5,2,-1),1,'Example 1');
is(rangeSum(1,3,1,-2,3,-4,5),-3,'Example 2');
is(rangeSum(3,4,1,0,2,-1,3),2,'Example 3');
is(rangeSum(0,3,-5,4,-3,2,-1,0),-2,'Example 4');
is(rangeSum(0,2,-1,0,2,-3,-2,1),1,'Example 5');

done_testing;
