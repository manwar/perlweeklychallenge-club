#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-287>

Author: Niels 'PerlBoy' van Dijke

Task 2: Valid Number
Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to find if it is a valid number.

Conditions for a valid number:

- An integer number followed by an optional exponent.
- A decimal number followed by an optional exponent.
- An integer number is defined with an optional sign '-' or '+' followed by digits.

Decimal Number:

A decimal number is defined with an optional sign '-' or '+' followed by one of the following definitions:
- Digits followed by a dot '.'.
- Digits followed by a dot '.' followed by digits.
- A dot '.' followed by digits.

Exponent:

An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use boolean;
use Scalar::Util qw(looks_like_number);

sub validNumber ($str) {
  boolean looks_like_number($str);
}

is(validNumber('1'),true);
is(validNumber('a'),false);
is(validNumber('1.2e4.2'),false);
is(validNumber('-1.'),true);
is(validNumber('+1E-8'),true);
is(validNumber('.44'),true);


done_testing;
