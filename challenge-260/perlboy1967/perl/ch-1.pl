#!/bin/perl

=pod

The Weekly Challenge - 260
- https://theweeklychallenge.org/blog/perl-weekly-challenge-260

Author: Niels 'PerlBoy' van Dijke

Task 1: Unique Occurrences
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return 1 if the number of occurrences of each value
in the given array is unique or 0 otherwise.

=cut

use v5.32;
use feature q(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(uniq);

sub uniqueOccurences (@ints) {
  my %f; $f{$_}++ for (@ints);
  0 + (keys(%f) == uniq values(%f));
}

is(uniqueOccurences(1,2,2,1,1,3),1);
is(uniqueOccurences(1,2,3),0);
is(uniqueOccurences(-2,0,1,-2,1,1,0,1,-2,9),1);

done_testing;
