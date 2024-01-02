#!/bin/perl

=pod

The Weekly Challenge - 250
- https://theweeklychallenge.org/blog/perl-weekly-challenge-250

Author: Niels 'PerlBoy' van Dijke

Task 2: Alphanumeric String Value
Submitted by: Mohammad S Anwar

You are given an array of alphanumeric strings.

Write a script to return the maximum value of alphanumeric string in the given array.

The value of alphanumeric string can be defined as

a) The numeric representation of the string in base 10 if it is made up of digits only.
b) otherwise the length of the string

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::Util qw(max);

sub alphanumericStringValue (@strings) {
  0 + max map { /^\d+$/ ? $_ : length $_ } @_;
}

is(alphanumericStringValue(qw(perl 2 000 python r4ku)),6);
is(alphanumericStringValue(qw(001 1 000 0001)),1);

done_testing;
