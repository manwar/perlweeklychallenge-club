#!/bin/perl

=pod

The Weekly Challenge - 246
- https://theweeklychallenge.org/blog/perl-weekly-challenge-246

Author: Niels 'PerlBoy' van Dijke

Task 2: Linear Recurrence of Second Order
Submitted by: Jorg Sommrey

You are given an array @a of five integers.

Write a script to decide whether the given integers form a linear recurrence
of second order with integer factors.

A linear recurrence of second order has the form

a[n] = p * a[n-2] + q * a[n-1] with n > 1

where p and q must be integers.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0;

use List::Util qw(sum0);
use List::MoreUtils qw(minmax);

sub _chk :prototype($$$\@) ($n,$p,$q,$arL) {
  $arL->[$n] == $p * $arL->[$n-2] + $q * $arL->[$n-1];
}

sub linearRecurrenceOfSecondOrder (@) {
  my @l = @_;
  my @i = (2..4);
  my ($min,$max) = minmax(@_);

  for my $p ($min..$max) {
    for my $q ($min..$max) {
      return [ $p, $q] if (sum0(map { _chk($_, $p, $q,@l) } @i) == 3);
    }
  }

  return [];
}


is(linearRecurrenceOfSecondOrder(1,1,2,3,5),[1,1]);
is(linearRecurrenceOfSecondOrder(4,2,4,5,7),[]);
is(linearRecurrenceOfSecondOrder(4,1,2,-3,8),[1,-2]);

done_testing;

