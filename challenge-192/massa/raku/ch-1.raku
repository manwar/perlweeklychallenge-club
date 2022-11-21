#!/usr/bin/env raku

=begin pod

Week 192:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-192

Task #1: Binary Flip

    You are given a positive integer, $n.

    Write a script to find the binary flip.

=end pod

use Test;

is 2, binary-flip 5;
is 3, binary-flip 4;
is 1, binary-flip 6;

done-testing;

sub binary-flip(UInt() $_) {
  +^$_ +^ (+^0 +< .base(2).chars)
}

