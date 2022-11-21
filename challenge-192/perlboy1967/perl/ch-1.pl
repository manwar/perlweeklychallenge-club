#!/bin/perl

=pod

The Weekly Challenge - 192
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-192/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Binary Flip
Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to find the binary flip.

=cut

use v5.16;
use warnings;

use Test::More;
use Benchmark qw(:all);


sub binaryFlipString ($) {
  return oct('0b'.sprintf('%b',$_[0]) =~ tr/01/10/r);
}

sub binaryFlipBinary ($) {
  my ($i,$m) = ($_[0],0);

  # Create bitmask for 'AND' below
  while ($i) {
    $i >>= 1; $m = ($m << 1) + 1;
  }

  return ~$_[0] & $m;
}
  

is(binaryFlipString(5),2);
is(binaryFlipString(5),2);
is(binaryFlipString(4),3);
is(binaryFlipString(6),1);
is(binaryFlipString(0b10101),0b1010);

is(binaryFlipBinary(5),2);
is(binaryFlipBinary(5),2);
is(binaryFlipBinary(4),3);
is(binaryFlipBinary(6),1);
is(binaryFlipBinary(0b10101),0b1010);

done_testing;

cmpthese(1_000_000, {
  'Binary' => sub{binaryFlipBinary(12345678)},
  'String' => sub{binaryFlipString(12345678)},
});
