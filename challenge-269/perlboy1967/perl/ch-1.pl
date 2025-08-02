#!/bin/perl

=pod

The Weekly Challenge - 269
- https://theweeklychallenge.org/blog/perl-weekly-challenge-269

Author: Niels 'PerlBoy' van Dijke

Task 1: Bitwise OR
Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to find out if it is possible to select two or more elements of 
the given array such that the bitwise OR of the selected elements has atlest one 
trailing zero in its binary representation.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

sub bitwiseOr (@ints) {
  my $c = 0;
  for (@ints) {
    $c++ if ($_ & 1) == 0;
    return 1 if $c > 1;
  }
  return 0;
}

is(bitwiseOr(1,2,3,4,5),1,'Example 1.1');
is(bitwiseOr(2,3,8,16),1,'Example 1.2');
is(bitwiseOr(1,2,5,7,9),0,'Example 1.3');

done_testing;
