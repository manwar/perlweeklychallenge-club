#!/bin/perl

=pod

The Weekly Challenge - 322
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-322#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Rank Array
Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return an array of the ranks of each element: the lowest
value has rank 1, next lowest rank 2, etc. If two elements are the same
then they share the same rank.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use List::MoreUtils qw(uniq);

sub rankArray (@ints) {
  my ($i,%idx) = (1);
  $idx{$_} = $i++ for uniq sort { $a <=> $b } @ints;
  return map { $idx{$_} } @ints;
}

is([rankArray(55,22,44,33)],[4,1,3,2],'Example 1');
is([rankArray(10,10,10)],[1,1,1],'Example 2');
is([rankArray(5,1,1,4,3)],[4,1,1,3,2],'Example 3');

done_testing;
