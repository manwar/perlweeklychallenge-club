#!/bin/perl

=pod

The Weekly Challenge - 325
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-325#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Consecutive One
Submitted by: Mohammad Sajid Anwar

You are given a binary array containing only 0 or/and 1.

Write a script to find out the maximum consecutive 1 in the given array.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use List::Util qw(max);

sub consecutiveOne (@binary) {
  return max (0, map { length } grep '1', split '0', join '', @binary);
}

is(consecutiveOne(0,1,1,0,1,1,1),3,'Example 1');
is(consecutiveOne(0,0,0,0),0,'Example 2');
is(consecutiveOne(1,0,1,0,1,1),2,'Example 3');

done_testing;
