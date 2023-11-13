#!/bin/perl

=pod

The Weekly Challenge - 243
- https://theweeklychallenge.org/blog/perl-weekly-challenge-243

Author: Niels 'PerlBoy' van Dijke

Task 2: Floor Sum
Submitted by: Mohammad S Anwar

You are given an array of positive integers (>=1).

Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j < nums.length. 
The floor() function returns the integer part of the division.

=cut

use v5.32;
use common::sense;

use Test2::V0;

use Algorithm::Combinatorics qw(variations_with_repetition);
use POSIX qw(floor);
use List::Util qw(sum0);

sub floorSum (@) {
  sum0 map { floor($$_[0] / $$_[1]) } variations_with_repetition([@_],2);
}

is(floorSum(2,5,9),10);
is(floorSum((7) x 7),49);

done_testing;
