#!/bin/perl

=pod

The Weekly Challenge - 276
- https://theweeklychallenge.org/blog/perl-weekly-challenge-276

Author: Niels 'PerlBoy' van Dijke

Task 2: Maximum Frequency
Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return the total number of elements in the given
array which have the highest frequency.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use List::AllUtils qw(sum0);

sub maximumFrequency (@ints) {
  my ($m,%f) = (0);
  map {$f{$_}++; $m++ if $f{$_} > $m} @ints;
  $m * scalar grep { $_ == $m } values %f;
}

is(maximumFrequency(1,2,2,4,1,5),4);
is(maximumFrequency(1,2,3,4,5),5);
is(maximumFrequency(1,1,3,3,5,5,7),6);

done_testing;
