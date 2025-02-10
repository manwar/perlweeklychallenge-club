#!/bin/perl

=pod

The Weekly Challenge - 303
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-308#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Decode XOR
Submitted by: Mohammad Sajid Anwar

You are given an encoded array and an initial integer.

Write a script to find the original array that produced the given encoded
array. It was encoded such that encoded[i] = orig[i] XOR orig[i + 1].

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

no warnings qw(experimental::signatures);

sub decodeXOR ($initial,@encoded) {
  my @l = ($initial);
  push(@l,$l[-1] ^ $_) for (@encoded);
  return @l;
}

is([decodeXOR(1,1,2,3)],[1,0,2,1],'Example 1');
is([decodeXOR(4,6,2,7,3)],[4,2,0,7,4],'Example 2');

done_testing;
