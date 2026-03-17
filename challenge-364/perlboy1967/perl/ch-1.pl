#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-364#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Decrypt String
Submitted by: Mohammad Sajid Anwar

You are given a string formed by digits and ‘#'.

Write a script to map the given string to English lowercase characters following the given rules.

- Characters 'a' to 'i' are represented by '1' to '9' respectively.
- Characters 'j' to 'z' are represented by '10#' to '26#' respectively.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub decryptString ($str) {
  state $n //= join('|',10..26);
  $str =~ s/((?<d>$n)#|(?<d>\d))/chr(96+$+{d})/ger;
}

is(decryptString('10#11#12'),'jkab','Example 1');
is(decryptString('1326#'),'acz','Example 2');
is(decryptString('25#24#123'),'yxabc','Example 3');
is(decryptString('20#5'),'te','Example 4');
is(decryptString('1910#26#'),'aijz','Example 5');
is(decryptString('27#'),'bg#','Own test');

done_testing;
