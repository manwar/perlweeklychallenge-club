#!/bin/perl

=pod

The Weekly Challenge - 244
- https://theweeklychallenge.org/blog/perl-weekly-challenge-244

Author: Niels 'PerlBoy' van Dijke

Task 1: Count Smaller
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer at each index.

=cut

use v5.32;
use common::sense;
use feature 'signatures';

use Test2::V0;

use List::Util qw(sum0);
use List::MoreUtils qw(frequency);

sub countSmaller(@int) {
  my %f = frequency(@int);

  map {
    my $i = shift @int;
    sum0 map { $f{$_} } grep { $_ < $i } keys %f;
  } 0 .. $#int;

}

is([countSmaller(8,1,2,2,3)],[4,0,1,1,3]);
is([countSmaller(6,5,4,8)],[2,1,0,3]);
is([countSmaller(2,2,2)],[0,0,0]);

done_testing;
