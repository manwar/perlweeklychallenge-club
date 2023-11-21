#!/bin/perl

=pod

The Weekly Challenge - 244
- https://theweeklychallenge.org/blog/perl-weekly-challenge-244

Author: Niels 'PerlBoy' van Dijke

Task 2: Group Hero
Submitted by: Mohammad S Anwar

You are given an array of integers representing the strength.

Write a script to return the sum of the powers of all possible combinations; power is
defined as the square of the largest number in a sequence, multiplied by the smallest.

=cut

use v5.32;
use common::sense;
use feature 'signatures';

use Test2::V0;

use List::Util qw(sum0);
use List::MoreUtils qw(minmax);
use Algorithm::Combinatorics qw(combinations);

sub groupHero(@int) {
  sum0 map {
    my $s;
    for my $c (combinations(\@int,$_)) {
      my ($min,$max) = minmax @$c;
      $s += $max ** 2 * $min;
    }
    $s;
  }  1 .. $#int + 1;
}

is(groupHero(2,1,4),141);

done_testing;

