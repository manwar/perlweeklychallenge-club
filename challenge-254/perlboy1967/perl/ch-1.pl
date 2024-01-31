#!/bin/perl

=pod

The Weekly Challenge - 254
- https://theweeklychallenge.org/blog/perl-weekly-challenge-254

Author: Niels 'PerlBoy' van Dijke

Task 1: Three Power
Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to return true if the given integer is a power of three otherwise return false.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

sub isPowerN ($n,$base) {
  return 1 if $n == 0;
  my $r = $n ** (1/$base);
  $r =~ m#^\d+$# ? 1 : 0;
}


is(isPowerN($_,3),1,"isPowerN($_,3) == 1") for (0,1,8,27,64);
is(isPowerN($_,3),0,"isPowerN($_,3) == 0") for (2,7,9,26,28,63,65);
is(isPowerN($_,5),1,"isPowerN($_,5) == 1") for (1,32,243);

done_testing;
