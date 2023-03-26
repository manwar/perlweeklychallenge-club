#!/bin/perl

=pod

The Weekly Challenge - 209
- https://theweeklychallenge.org/blog/perl-weekly-challenge-209

Author: Niels 'PerlBoy' van Dijke

Task 1: Special Bit Characters
Submitted by: Mohammad S Anwar

You are given an array of binary bits that ends with 0.

Valid sequences in the bit string are:

[0] -decodes-to-> "a"
[1, 0] -> "b"
[1, 1] -> "c"

Write a script to print 1 if the last character is an “a” otherwise print 0.

=cut

use v5.16;

use common::sense;

use Test::More;

sub isSpecialBitCharacter {
  return 0 if $_[-1];
  return (split /(11|10)/,join '',@_ )[-1] ? 0 : 1;
}

is(isSpecialBitCharacter(1,0,0),1);
is(isSpecialBitCharacter(1,1,1,0),0);
is(isSpecialBitCharacter(1,0,0,1,1,0),1);
is(isSpecialBitCharacter(1,1,0,0,0,1,0),0);
is(isSpecialBitCharacter(1,0,1,0,1,1,0),1);

done_testing;
