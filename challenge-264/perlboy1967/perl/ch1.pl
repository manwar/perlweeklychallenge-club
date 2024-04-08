#!/bin/perl

=pod

The Weekly Challenge - 264
- https://theweeklychallenge.org/blog/perl-weekly-challenge-264

Author: Niels 'PerlBoy' van Dijke

Task 1: Greatest English Letter
Submitted by: Mohammad Sajid Anwar

You are given a string, $str, made up of only alphabetic characters [a..zA..Z].

Write a script to return the greatest english letter in the given string.

|| A letter is greatest if it occurs as lower and upper case. Also letter ‘b’ is
|| greater than ‘a’ if ‘b’ appears after ‘a’ in the English alphabet.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(firstres);

sub greatestEnglishLetter($str) {
  my %c = map { $_ => 1 } split //,$str;
  (firstres { $_ if exists $c{lc $_} } 
            reverse sort grep /^[A-Z]$/, keys %c) // '';
}

is(greatestEnglishLetter('PeRlwEeKLy'),'L','Example 1');
is(greatestEnglishLetter('ChaLlenge'),'L','Example 2');
is(greatestEnglishLetter('The'),'','Example 3');

done_testing;
