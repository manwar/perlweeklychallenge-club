#!/bin/perl

=pod

The Weekly Challenge - 309
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-309#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Min Gap
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, increasing order.

Write a script to return the element before which you find the smallest gap.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

no warnings qw(experimental::signatures);

use List::MoreUtils qw(slide);

sub minGap (@ints) {
  my ($min,$n);

  slide {
    my $d = abs($a - $b);
    ($min,$n) = ($d,$b) if (!defined $min or $min > $d);
  } @ints;

  return $n;
}

is(minGap(2,8,10,11,15),11,'Example 1');
is(minGap(1,5,6,7,14),6,'Example 2');
is(minGap(8,20,25,28),28,'Example 3');

done_testing;
