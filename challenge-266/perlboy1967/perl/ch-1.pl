#!/bin/perl

=pod

The Weekly Challenge - 266
- https://theweeklychallenge.org/blog/perl-weekly-challenge-266

Author: Niels 'PerlBoy' van Dijke

Task 1: Uncommon Words
Submitted by: Mohammad Sajid Anwar

You are given two sentences, $line1 and $line2.

Write a script to find all uncommmon words in any order in the given two sentences.
Return ('') if none found.

|| A word is uncommon if it appears exactly once in one of the sentences and doesn’t
appear in other sentence.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

sub uncommonWords ($line1,$line2) {
  my %f; $f{lc $_}++ for (split /\s+/, "$line1 $line2");
  my @w = grep { $f{$_} == 1 } sort keys %f;
  return @w ? @w : '';
}

is([uncommonWords('Mango is sweet','Mango is sour')],['sour','sweet']);
is([uncommonWords('Mango Mango','Orange')],['orange']);
is([uncommonWords('Mango is Mango','Orange is Orange')],['']);

done_testing;
