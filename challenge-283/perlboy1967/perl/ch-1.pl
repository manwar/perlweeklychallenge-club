#!/bin/perl

=pod

The Weekly Challenge - 283
- L<https://theweeklychallenge.org/blog/perl-weekly-challenge-283>

Author: Niels 'PerlBoy' van Dijke

Task 1: Unique Number
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, where every elements appears
more than once except one element.

Write a script to find the one element that appears exactly one time.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use List::MoreUtils qw(singleton);

sub uniqueNumber (@ints) {
  my @s = singleton(@ints);
  @s == 1 ? $s[0] : undef;
}

is(uniqueNumber(3,3,1),1,'Example 1');
is(uniqueNumber(3,2,4,2,4),3,'Example 2');
is(uniqueNumber(1),1,'Example 3');
is(uniqueNumber(4,3,1,1,1,4),3,'Example 4');
is(uniqueNumber(),undef,'Own test 1');
is(uniqueNumber(1,1),undef,'Own test 2');
is(uniqueNumber(1,2),undef,'Own test 3');

done_testing;
