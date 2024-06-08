#!/bin/perl

=pod

The Weekly Challenge - 272
- https://theweeklychallenge.org/blog/perl-weekly-challenge-272

Author: Niels 'PerlBoy' van Dijke

Task 2: String Score
Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to return the score of the given string.

|| The score of a string is defined as the sum of the absolute difference
|| between the ASCII values of adjacent characters.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);;

use List::Util qw(sum0);
use List::MoreUtils qw(slide);

sub stringScore ($str) {
  sum0 slide { abs(ord($a) - ord($b)) } split //, $str;
}

is(stringScore('hello'),13,'Example 1');
is(stringScore('perl'),30,'Example 2');
is(stringScore('raku'),37,'Example 3');

done_testing;

