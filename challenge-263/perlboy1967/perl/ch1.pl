#!/bin/perl

=pod 

The Weekly Challenge - 263
- https://theweeklychallenge.org/blog/perl-weekly-challenge-263

Author: Niels 'PerlBoy' van Dijke

Task 1: Max Positive Negative
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the maximum number of either positive or
negative integers in the given array.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(indexes);

sub targetIndex ($k,@ints) {
  indexes { $_ == $k } sort { $a <=> $b } @ints;
}

is([targetIndex(2,1,5,3,2,4,2)],[1,2]);
is([targetIndex(6,1,2,3,4,5)],[]);
is([targetIndex(4,5,3,2,4,2,1)],[4]);

done_testing;
