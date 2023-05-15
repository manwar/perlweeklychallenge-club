#!/bin/perl

=pod

The Weekly Challenge - 217
- https://theweeklychallenge.org/blog/perl-weekly-challenge-217

Author: Niels 'PerlBoy' van Dijke

Task 2: Max Number
Submitted by: Mohammad S Anwar

You are given a list of positive integers.

Write a script to concatenate the integers to form the highest possible value.

=cut

use v5.16;

use common::sense;

use Test::More;

sub maxNumber (@) {
  join('',sort{"$b$a"<=>"$a$b"}@_);
}

is(maxNumber(1,23),231);
is(maxNumber(10,3,2),3210);
is(maxNumber(31,2,4,10),431210);
is(maxNumber(5,11,4,1,2),542111);
is(maxNumber(1,10),110);

done_testing;
