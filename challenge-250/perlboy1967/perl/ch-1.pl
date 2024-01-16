#!/bin/perl

=pod

The Weekly Challenge - 250
- https://theweeklychallenge.org/blog/perl-weekly-challenge-250

Author: Niels 'PerlBoy' van Dijke

Task 1: Smallest Index
Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to find the smallest index i such that i mod 10 == $ints[i] otherwise return -1.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::MoreUtils qw(first_index);

sub smallestIndex (@ints) {
  first_index { $_ % 10 == $_[$_] } 0 .. $#_;
}

is(smallestIndex(0,1,2),0);
is(smallestIndex(4,3,2,1),2);
is(smallestIndex(1,2,3,4,5,6,7,8,9,0),-1);

done_testing;
