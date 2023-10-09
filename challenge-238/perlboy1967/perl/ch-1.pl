#!/bin/perl

=pod

The Weekly Challenge - 238
- https://theweeklychallenge.org/blog/perl-weekly-challenge-238

Author: Niels 'PerlBoy' van Dijke

Task 1: Running Sum
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to return the running sum of the given array. The running 
sum can be calculated as sum[i] = num[0] + num[1] + ... + num[i].

=cut

use v5.32;
use common::sense;
use feature 'signatures';

use Test::More;
use Test::Deep qw(cmp_deeply);


sub runningSum (@numbers) {
  my $s = 0;
  return map { $s += $_; } @numbers;
}

cmp_deeply([runningSum(1,2,3,4,5)],[1,3,6,10,15]);
cmp_deeply([runningSum(1,1,1,1,1)],[1,2,3,4,5]);
cmp_deeply([runningSum(0,-1,1,2)],[0,-1,0,2]);

done_testing;
