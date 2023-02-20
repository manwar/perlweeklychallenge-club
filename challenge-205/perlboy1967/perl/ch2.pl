#!/bin/perl

=pod

The Weekly Challenge - 205
- https://theweeklychallenge.org/blog/perl-weekly-challenge-205

Author: Niels 'PerlBoy' van Dijke

Task 2: Maximum XOR
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find the highest value obtained by XORing any two distinct members of the array.

=cut

use v5.16;

use common::sense;

use List::MoreUtils qw(uniq);
use Algorithm::Combinatorics qw(combinations);

use Test::More;

sub maXor ($@) {
  my (@l) = uniq(@_);
  my $max;

  for (combinations(\@l,2)) {
    my $xor = $$_[0] ^ $$_[1];
    $max = $xor if (!defined $max or $max < $xor);
  }

  return $max;
}

is(7,maXor(1,2,3,4,5,6,7));
is(7,maXor(2,4,1,3));
is(15,maXor(10,5,7,12,8));

done_testing;
