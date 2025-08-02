#!/bin/perl

=pod

The Weekly Challenge - 255
- https://theweeklychallenge.org/blog/perl-weekly-challenge-255

Author: Niels 'PerlBoy' van Dijke

Task 1: Odd Character
Submitted by: Mohammad Sajid Anwar

You are given two strings, $s and $t. The string $t is generated using the shuffled
characters of the string $s with an additional character.

Write a script to find the additional character in the string $t.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::MoreUtils qw(firstidx);

sub oddCharacter ($s,$t) {
  my @s = sort split //, $s;
  my @t = sort split //, $t;
  return $t[firstidx { $s[$_] ne $t[$_] } 0 .. $#s];
}

is(oddCharacter('Perl','Preel'),'e');
is(oddCharacter('Weekly','Weeakly'),'a');
is(oddCharacter('Box','Boxy'),'y');

done_testing;
