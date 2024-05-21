#!/bin/perl

=pod

The Weekly Challenge - 270
- https://theweeklychallenge.org/blog/perl-weekly-challenge-270

Author: Niels 'PerlBoy' van Dijke

Task 1: Special Positions
Submitted by: Mohammad Sajid Anwar

You are given a m x n binary matrix.

Write a script to return the number of special positions in the given binary matrix.

|| A position (i, j) is called special if $matrix[i][j] == 1 and all other elements
|| in the row i and column j are 0.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;;

# Task 1
sub specialPositions ($ar) {
  sub _isSpecial (@ints) {
    my %i; $i{$_}++ for (@ints); 
    return (keys %i == 2 && $i{1} == 1 && exists $i{0} ? 1 : 0);
  }
  my @r = map { _isSpecial(@$_) } @$ar;
  my @c = map { my $c = $_; 
                _isSpecial(map{$$ar[$_][$c]} 0 .. $#{$$ar[0]})
              } 0 .. $#$ar;
  my $n = 0;
  for my $r (0 .. $#r) {
    for my $c (0 .. $#c) {
      $n++ if $$ar[$r][$c] & $r[$r] & $c[$c];
    }
  }
  return $n;
}

is(specialPositions([[1,0,0,],
                     [0,0,1,],
                     [1,0,0]]),1,'Example 1');
is(specialPositions([[1,0,0],
                     [0,1,0],
                     [0,0,1]]),3,'Example 2');
done_testing;
