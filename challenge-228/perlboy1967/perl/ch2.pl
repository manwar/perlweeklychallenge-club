#!/bin/perl

=pod

The Weekly Challenge - 228
- https://theweeklychallenge.org/blog/perl-weekly-challenge-228

Author: Niels 'PerlBoy' van Dijke

Task 2: Empty Array
Submitted by: Mohammad S Anwar

You are given an array of integers in which all elements are unique.

Write a script to perform the following operations until the array is 
empty and return the total count of operations.

=cut

use v5.16;

use common::sense;

use Test::More;

use List::Util qw(min);

sub emptyArray (@) {
  my $n = 0;

  while (@_) {
    my $v = shift @_; push(@_,$v) if (min(@_,$v) != $v);
    $n++;
  }

  return $n;
}

is(emptyArray(3,4,2),5);
is(emptyArray(1,2,3),3);

done_testing;
