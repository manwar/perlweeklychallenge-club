#!/bin/perl

=pod

The Weekly Challenge - 256
- https://theweeklychallenge.org/blog/perl-weekly-challenge-256

Author: Niels 'PerlBoy' van Dijke

Task 1: Maximum Pairs
Submitted by: Mohammad Sajid Anwar

You are given an array of distinct words, @words.

Write a script to find the maximum pairs in the given array. The words $words[i]
and $words[j] can be a pair one is reverse of the other.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

sub maximumPairs(@words) {
  my ($n,%w) = (0);

  for (@words) {
    $n++ if exists $w{reverse $_};
    $w{$_}++;
  }

  return $n;
}

is(maximumPairs(qw(ab de ed bc)),1);
is(maximumPairs(qw(aa ba cd ed)),0);
is(maximumPairs(qw(uv qp st vu mn pq)),2);

done_testing;
