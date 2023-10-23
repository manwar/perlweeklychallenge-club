#!/bin/perl

=pod

The Weekly Challenge - 240
- https://theweeklychallenge.org/blog/perl-weekly-challenge-240

Author: Niels 'PerlBoy' van Dijke

Task 2: Build Array
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to create an array such that 
new[i] = old[old[i]] where 0 <= i < new.length.

=cut

use v5.32;
use common::sense;
use feature 'signatures';

use Test2::V0;

sub buildArray (@int) {
  [map { $int[$int[$_]] } (0 .. scalar(@int) - 1)];
}

is(buildArray(0,2,1,5,3,4),[0,1,2,4,5,3]);
is(buildArray(5,0,1,2,3,4),[4,5,0,1,2,3]);

done_testing;
