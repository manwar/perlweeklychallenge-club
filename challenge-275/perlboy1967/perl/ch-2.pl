#!/bin/perl

=pod

The Weekly Challenge - 275
- https://theweeklychallenge.org/blog/perl-weekly-challenge-275

Author: Niels 'PerlBoy' van Dijke

Task 2: Replace Digits
Submitted by: Mohammad Sajid Anwar

You are given an alphanumeric string, $str, where each character
is either a letter or a digit.

Write a script to replace each digit in the given string with the
value of the previous letter plus (digit) places.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

sub replaceDigits ($str) {
  my $r;
  while ($str =~ s#^(?<c>[a-z])(?<d>\d+)##i) {
    $r .= $+{c} . join('', map { chr(ord($+{c})+$_) } split(//,$+{d}));
  }
  return $r.$str;
}

is(replaceDigits('a1c1e1'),'abcdef','Example 1');
is(replaceDigits('a1b2c3d4'),'abbdcfdh','Example 2');
is(replaceDigits('b2b'),'bdb','Example 3');
is(replaceDigits('a16z'),'abgz','Example 4');
is(replaceDigits('Z5'),'Z_','Own test');

done_testing;
