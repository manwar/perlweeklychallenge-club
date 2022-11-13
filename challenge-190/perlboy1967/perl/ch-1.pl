#!/bin/perl

=pod

The Weekly Challenge - 190
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-190/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Capital Detection
Submitted by: Mohammad S Anwar

You are given a string with alphabetic characters only: A..Z and a..z.

Write a script to find out if the usage of Capital is appropriate if it satisfies
at least one of the following rules:

1) Only first letter is capital and all others are small.
2) Every letter is small.
3) Every letter is capital.

=cut

use v5.16;
use warnings;

use Test::More;

sub captitalDetection ($) {
  return ($_[0] =~ m#^([A-Z][a-z]+|[a-z]+|[A-Z]+)$# ? 1 : 0);
}

is(captitalDetection('Perl'),1);
is(captitalDetection('TPF'),1);
is(captitalDetection('PyThon'),0);
is(captitalDetection('raku'),1);

done_testing;
