#!/bin/perl

=pod

The Weekly Challenge - 234
- https://theweeklychallenge.org/blog/perl-weekly-challenge-234

Author: Niels 'PerlBoy' van Dijke

Task 2: Unequal Triplets
Submitted by: Mohammad S Anwar

You are given an array of positive integers.

Write a script to find the number of triplets (i, j, k) that satisfies
num[i] != num[j], num[j] != num[k] and num[k] != num[i].

=cut

use v5.16;

use common::sense;

use Test::More;

use List::Util qw(sum0);
use Algorithm::Combinatorics qw(combinations);

sub unequalTriplets (@) {
  my (%f,@n,@r);

  $f{$_}++ for (@_);
  @n = sort { $a <=> $b } keys %f;

  return 0 if (@n < 3);

  my @c = combinations(\@n,3);
  push(@r, $f{$$_[0]} * $f{$$_[1]} * $f{$$_[2]}) for (@c);

  return sum0(@r); 

}

is(unequalTriplets(4, 4, 2, 4, 3),3);
is(unequalTriplets(1, 1, 1, 1, 1),0);
is(unequalTriplets(4, 7, 1, 10, 7, 4, 1, 1), 28);

done_testing;
