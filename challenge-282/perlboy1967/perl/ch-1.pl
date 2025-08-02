#!/bin/perl

=pod

The Weekly Challenge - 282
- https://theweeklychallenge.org/blog/perl-weekly-challenge-282

Author: Niels 'PerlBoy' van Dijke

Task 1: Good Integer
Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int, having 3 or more digits.

Write a script to return the Good Integer in the given integer or -1 if none found.

|| A good integer is exactly three consecutive matching digits.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

# Task 1
sub goodInteger ($int) {
  while ($int =~ /(.?)(.)(\2\2)(.?)/g) {
    return int($2.$3) if ($1 ne $2 && $2 ne $4);
    pos($int) = length($`) + 3;
  } 
  return -1;
}

is(goodInteger(12344456),444,'Example 1');
is(goodInteger(1233334),-1,'Example 2');
is(goodInteger(10020003),0,'Example 3');
is(goodInteger(10023000),0,'Own test 1');
is(goodInteger(22220111),111,'Own test 2');

done_testing;
