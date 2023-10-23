#!/bin/perl

=pod

The Weekly Challenge - 240
- https://theweeklychallenge.org/blog/perl-weekly-challenge-240

Author: Niels 'PerlBoy' van Dijke

Task 1: Acronym
Submitted by: Mohammad S Anwar

You are given two arrays of strings and a check string.

Write a script to find out if the check string is the acronym of the words
in the given array.

=cut

use v5.32;
use common::sense;
use feature 'signatures';

use Test2::V0;

sub acronym ($string,@words) {
  lc($string) eq join('',map {lc substr($_,0,1)} @words) ? 1 : 0;
}

is(acronym('ppp','Perl','Python','Pascal'),1);
is(acronym('rp','Perl','Raku'),0);
is(acronym('oac','Oracle','Awk','C'),1);

done_testing;
