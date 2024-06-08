#!/bin/perl

=pod

The Weekly Challenge - 271
- https://theweeklychallenge.org/blog/perl-weekly-challenge-271

Author: Niels 'PerlBoy' van Dijke

Task 1: Maximum Ones
Submitted by: Mohammad Sajid Anwar

You are given a m x n binary matrix.

Write a script to return the row number containing maximum ones,
in case of more than one rows then return smallest row number.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(max);

sub maximumOnes ($ar) {
  my ($i,%m) = (1);
  map {push(@{$m{grep{$_ == 1} @$_}}, $i++)} @$ar;
  shift(@{$m{max keys %m}});
}

is(maximumOnes([[0,1],[1,0]]),1,'Example 1');
is(maximumOnes([[0,0,0],[1,0,1]]),2,'Example 2');
is(maximumOnes([[0,0],[1,1],[0,0]]),2,'Example 3');

done_testing;
