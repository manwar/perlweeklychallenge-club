#!/bin/perl

=pod

The Weekly Challenge - 239
- https://theweeklychallenge.org/blog/perl-weekly-challenge-239

Author: Niels 'PerlBoy' van Dijke

Task 2: Consistent Strings
Submitted by: Mohammad S Anwar

You are given an array of strings and allowed string having distinct characters.

|| A string is consistent if all characters in the string appear in the string allowed.

Write a script to return the number of consistent strings in the given array.

=cut

use v5.32;
use common::sense;
use feature 'signatures';

use Test::More;

sub consistentStrings ($allowed,@strings) {
  my $re = "[^$allowed]";
  grep { length and !/$re/ } @strings;
}

is(consistentStrings('ab',qw(ad bd aaab baa badab)),2);
is(consistentStrings('abc',qw(a b c ab ac bc abc)),7);
is(consistentStrings('cad',qw(cc acd b ba bac bad ac d)),4);
is(consistentStrings('a','a',''),1);

done_testing;
