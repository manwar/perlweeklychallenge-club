#!/bin/perl

=pod

The Weekly Challenge - 277
- https://theweeklychallenge.org/blog/perl-weekly-challenge-277

Author: Niels 'PerlBoy' van Dijke

Task 2: Strong Pair
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the count of all strong pairs in the given array.

|| A pair of integers x and y is called strong pair if it satisfies:
|| 0 < |x - y| < min(x, y).

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use Algorithm::Combinatorics qw(combinations);
use List::AllUtils qw(min uniq);

sub strongPair (@ints) {
  @ints = uniq(@ints);
  scalar grep { abs($$_[0]-$$_[1]) < min(@$_) } combinations(\@ints,2);
}

is(strongPair(1..5),4);
is(strongPair(5,7,1,7),1);

done_testing;
