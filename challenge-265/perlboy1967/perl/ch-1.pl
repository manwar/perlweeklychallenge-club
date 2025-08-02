#!/bin/perl

=pod

The Weekly Challenge - 265
- https://theweeklychallenge.org/blog/perl-weekly-challenge-265

Author: Niels 'PerlBoy' van Dijke

Task 1: 33% Appearance
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find an integer in the given array that appeared 33% or more.
If more than one found, return the smallest. If none found then return undef.

=cut


use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(max);
use POSIX qw(ceil);

sub arbitraryAppearance ($arInts,$perc) {
  my %freq;
  $freq{$_}++ for (@$arInts);

  my $minFreq = ceil($#{$arInts} * $perc / 100);
  my $reqFreq = max(values %freq);

  return if $reqFreq < $minFreq;

  my @candidates = grep { $freq{$_} == $reqFreq } sort { $a <=> $b } keys %freq;
  return $candidates[0];
}

is(arbitraryAppearance([1,2,3,3,3,3,4,2],33),3,'Example 1');
is(arbitraryAppearance([1,1],33),1,'Example 2');
is(arbitraryAppearance([1,2,3],33),1,'Example 3');
is(arbitraryAppearance([1,1,2,2,3,3,4,4],33),undef,'Own test');

done_testing;
