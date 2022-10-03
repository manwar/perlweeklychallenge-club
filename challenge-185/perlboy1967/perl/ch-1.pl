#!/bin/perl

=pod

The Weekly Challenge - 185
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-185/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Mask Code
Submitted by: Mohammad S Anwar

You are given a list of codes in many random format.

Write a script to mask first four characters (a-z,0-9) and keep the rest as it is.

=cut

use v5.16;
use warnings;

use Test::More;


sub macFormat ($) {
  state $re = join '\.', ('([0-9a-f]{2})' x 2) x 3;
  return join(':',$1,$2,$3,$4,$5,$6)
    if ($_[0] =~ /(?i)^$re$/o);
}


is(macFormat('1ac2.34f0.b1c2'),'1a:c2:34:f0:b1:c2');
is(macFormat('ABC1.20F1.345A'),'AB:C1:20:F1:34:5A');

done_testing;    
