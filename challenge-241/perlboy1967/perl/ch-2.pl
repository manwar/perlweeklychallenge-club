#!/bin/perl

=pod

The Weekly Challenge - 241
- https://theweeklychallenge.org/blog/perl-weekly-challenge-241

Author: Niels 'PerlBoy' van Dijke

Task 2: Prime Order
Submitted by: Mohammad S Anwar

You are given an array of unique positive integers greater than 2.

Write a script to sort them in ascending order of the count of their prime factors, tie-breaking
by ascending value.

=cut

use v5.32;
use common::sense;

use Math::Prime::Util qw(factor);

use Test2::V0;

sub _cmpLists (\@\@) {
  my $r = 0;

  for (1 .. $_[0]->$#*) {
    $r = $_[0]->[$_] <=> $_[1]->[$_];
    return $r if $r != 0;
  }

  return 0;
}

sub primeOrder (@) {
  map { $_->[0] } sort { 
    scalar(@$a) <=> scalar(@$b)
                || 
            _cmpLists(@{$a},@{$b}) 
  } map { [$_, factor($_)] } @_;

}

is([primeOrder(11,8,27,4)],[11,4,8,27]);
is([primeOrder(15,3,4,2,12)],[2,3,4,15,12]);

done_testing;
