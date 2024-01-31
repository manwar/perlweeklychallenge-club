#!/bin/perl

=pod

The Weekly Challenge - 254
- https://theweeklychallenge.org/blog/perl-weekly-challenge-254

Author: Niels 'PerlBoy' van Dijke

Task 2: Reverse Vowels
Submitted by: Mohammad S Anwar

You are given a string, $s.

Write a script to reverse all the vowels (a, e, i, o, u) in the given string.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

sub reverseVowels ($str) {
  my @v = $str =~ m/(?i)[aeiou]/g;
  ucfirst lc $str =~ s/(?i)[aeiou]/pop @v/egr;
}


is(reverseVowels('Raku'),'Ruka');
is(reverseVowels('Perl'),'Perl');
is(reverseVowels('Julia'),'Jaliu');
is(reverseVowels('Uiua'),'Auiu');

done_testing;
