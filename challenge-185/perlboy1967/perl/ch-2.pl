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
use Test::Deep qw(cmp_deeply);


sub maskcode {
  state $re = '([^0-9a-z]*)([0-9a-z])' x 4;
  my @r;
  for (@_) {
    push(@r,s/^$re/$1x$3x$5x$7x/or);
  }
  @r;
}

   
cmp_deeply([maskcode('ab-cde-123', '123.abc.420', '3abc-0010.xy')],
           ['xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy']);
cmp_deeply([maskcode('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')],
           ['xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f']);

done_testing;
