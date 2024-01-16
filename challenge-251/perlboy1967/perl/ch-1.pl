#!/bin/perl

=pod

The Weekly Challenge - 251
- https://theweeklychallenge.org/blog/perl-weekly-challenge-251

Author: Niels 'PerlBoy' van Dijke

Task 1: Concatenation Value
Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to find the concatenation value of the given array.

The concatenation of two numbers is the number formed by concatenating
their numerals.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::Util qw(sum0);

sub concatenationValue (@ints) {
  # splice in an extra 0 if the list has odd number of elements
  splice(@ints,$#ints/2-1,1,$ints[$#ints/2-1],0) if ($#ints % 2 == 0);
  my $i = 0;
  sum0 map { "$ints[$_]$ints[--$i]" } 0 .. $#ints/2;
}

is(concatenationValue(6,12,25,1),1286);
is(concatenationValue(10,7,31,5,2,2),489);
is(concatenationValue(1,2,10),112);

done_testing;
