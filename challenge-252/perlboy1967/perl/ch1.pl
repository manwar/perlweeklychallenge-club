#!/bin/perl

=pod

The Weekly Challenge - 252
- https://theweeklychallenge.org/blog/perl-weekly-challenge-252

Author: Niels 'PerlBoy' van Dijke

Task 1: Special Numbers
Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to find the sum of the squares of all special elements of the given array.

|| An element $int[i] of @ints is called special if i divides n, i.e. n % i == 0.
|| Where n is the length of the given array. Also the array is 1-indexed for the task.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0;

use List::Util qw(sum0);

sub specialNumbers (@ints) {
  my $n = $#ints + 1;
  sum0 map { $ints[$_ - 1] ** 2 } grep { $n % $_ == 0 } 1 .. $n;
}

is(specialNumbers(1,2,3,4),21);
is(specialNumbers(2,7,1,19,18,3),63);

done_testing;
