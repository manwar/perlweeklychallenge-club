#!/bin/perl

=pod

The Weekly Challenge - 233
- https://theweeklychallenge.org/blog/perl-weekly-challenge-233

Author: Niels 'PerlBoy' van Dijke

Task 2: Frequency Sort
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to sort the given array in increasing order based on the
frequency of the values. If multiple values have the same frequency then
sort them in decreasing order.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep qw(cmp_deeply);

sub frequencySort (@) {
  my %f;
  $f{$_}++ for (@_);

  map {($_) x $f{$_}} sort { $f{$a} <=> $f{$b} or $b <=> $a } keys %f;
}

cmp_deeply([frequencySort(1,1,2,2,2,3)],
           [3,1,1,2,2,2]);
cmp_deeply([frequencySort(2,3,1,3,2)],
           [1,3,3,2,2]);

done_testing;
