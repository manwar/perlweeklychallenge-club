#!/bin/perl

=pod

The Weekly Challenge - 321
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-321#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Distinct Average
Submitted by: Mohammad Sajid Anwar

You are given an array of numbers with even length.

Write a script to return the count of distinct average. The average is
calculate by removing the minimum and the maximum, then average of the two.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub distinctAverage (@ints) {
  my %f;
  @ints = sort { $a <=> $b } @ints;
  $f{(shift(@ints)+pop(@ints))/2}++ while (@ints > 1);
  $f{$ints[0]}++ if @ints;
  return (sort { $a <=> $b } values %f)[-1];
}

is(distinctAverage(1,2,4,3,5,6),3,'Example 1');
is(distinctAverage(0,2,4,8,3,5),2,'Example 2');
is(distinctAverage(7,3,1,0,5,9),2,'Example 3');
is(distinctAverage(1,2,3,4,5),3,'Own example');

done_testing;
