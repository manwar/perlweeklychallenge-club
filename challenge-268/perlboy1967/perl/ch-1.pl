#!/bin/perl

=pod

The Weekly Challenge - 268
- https://theweeklychallenge.org/blog/perl-weekly-challenge-268

Author: Niels 'PerlBoy' van Dijke

Task 1: Magic Number
Submitted by: Mohammad Sajid Anwar

You are given two arrays of integers of same size, @x and @y.

Write a script to find the magic number that when added to each 
elements of one of the array gives the second array. Elements order
is not important.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(pairwise uniq);

sub magicNumber($ar1,$ar2) {
  my @d = uniq pairwise { $b - $a } 
                        @{[sort {$a <=> $b} @$ar1]},
                        @{[sort {$a <=> $b} @$ar2]};
  return (@d == 1 ? $d[0] : undef);
}

is(magicNumber([3,7,5],[9,5,7]),2,'Example 1');
is(magicNumber([1,2,1],[5,4,4]),3,'Example 2');
is(magicNumber([2],[5]),3,'Example 3');
is(magicNumber([0,1],[2,4]),undef,'Own test');

done_testing;
