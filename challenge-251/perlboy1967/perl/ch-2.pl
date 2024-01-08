#!/bin/perl

=pod

The Weekly Challenge - 251
- https://theweeklychallenge.org/blog/perl-weekly-challenge-251

Author: Niels 'PerlBoy' van Dijke

Task 2: Lucky Numbers
Submitted by: Mohammad S Anwar

You are given a m x n matrix of distinct numbers.

Write a script to return the lucky number, if there is one, or -1 if not.

A lucky number is an element of the matrix such that it is
the minimum element in its row and maximum in its column.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::Util qw(min max);
use List::MoreUtils qw(duplicates);

sub luckyNumber ($ar) {
  my @min = map { min @{$$ar[$_]} } 0 .. $#$ar;
  my @max = map { my $c = $_; 
                  max map { $$ar[$_][$c] } 0 .. $#$ar 
                } 0 .. $#{$ar->[0]};
  (duplicates @min,@max)[0];
}

is(luckyNumber([ [ 3,  7,  8],
                 [ 9, 11, 13],
                 [15, 16, 17] ]),15);
is(luckyNumber([ [ 1, 10,  4,  2],
                 [ 9,  3,  8,  7],
                 [15, 16, 17, 12] ]),12);
is(luckyNumber([ [7 ,8],
                 [1 ,2] ]), 7);

done_testing;
