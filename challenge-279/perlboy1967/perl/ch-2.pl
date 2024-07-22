#!/bin/perl

=pod

The Weekly Challenge - 279
- https://theweeklychallenge.org/blog/perl-weekly-challenge-279

Author: Niels 'PerlBoy' van Dijke

Task 2: Split String
Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to split the given string into two containing exactly
same number of vowels and return true if you can otherwise false.

=cut

use v5.32;
no warnings 'experimental::signatures';
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

sub splitString ($str) {
  $str =~ tr/aeiouy// % 2 ? 0 : $str =~ m#[aeiouy][^aeiouy]+$# ? 1 : 0;
}

is(splitString('perl'),0,'Example 1');
is(splitString('book'),1,'Example 2');
is(splitString('good morning'),1,'Example 2');

done_testing;
