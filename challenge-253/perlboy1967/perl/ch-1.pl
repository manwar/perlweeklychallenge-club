#!/bin/perl

=pod

The Weekly Challenge - 253
- https://theweeklychallenge.org/blog/perl-weekly-challenge-253

Author: Niels 'PerlBoy' van Dijke

Task 1: Split Strings
Submitted by: Mohammad S Anwar

You are given an array of strings and a character separator.

Write a script to return all words separated by the given character excluding empty string.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

sub splitStrings ($sep,@str) {
  $sep = quotemeta $sep;
  grep /\S/, map { split $sep } @str;
}

is([splitStrings('.','one.two.three','four.five','six')],
   ['one','two','three','four','five','six']);
is([splitStrings('$','$perl$$','$$raku$')],
   ['perl','raku']);

done_testing;
