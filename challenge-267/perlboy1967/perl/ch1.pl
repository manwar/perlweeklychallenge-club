#!/bin/perl

=pod

The Weekly Challenge - 267
- https://theweeklychallenge.org/blog/perl-weekly-challenge-267

Author: Niels 'PerlBoy' van Dijke

Task 1: Product Sign
Submitted by: Mohammad Sajid Anwar

You are given an array of @ints.

Write a script to find the sign of product of all integers in the given
array. The sign is 1 if the product is positive, -1 if the product is
negative and 0 if product is zero.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

sub productSign (@ints) {
  my $sign = 1;
  for (@ints) {
    return 0 if $_ == 0;
    $sign *= ($_ > 0 ? 1 : -1);
  }
  return $sign;
}

is(productSign(-1,-2,-3,-4,3,2,1),1,'Example 1');
is(productSign(1,2,0,-2,-1),0,'Example 2');
is(productSign(-1,-1,1,-1,2),-1,'Example 3');

done_testing;
