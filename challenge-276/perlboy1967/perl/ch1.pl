#!/bin/perl

=pod

The Weekly Challenge - 276
- https://theweeklychallenge.org/blog/perl-weekly-challenge-276

Author: Niels 'PerlBoy' van Dijke

Task 1: Complete Day
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @hours.

Write a script to return the number of pairs that forms a complete day.

|| A complete day is defined as a time duration that is an exact multiple
|| of 24 hours.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);
use DDP;

use Algorithm::Combinatorics qw(combinations);

sub completeDay (@hours) {
  grep { $_ % 24 == 0 } map { $$_[0] + $$_[1] } combinations(\@hours,2);
}

is(completeDay(12,12,30,24,24),2);
is(completeDay(72,48,24,5),3);
is(completeDay(12,18,24),0);

done_testing;
