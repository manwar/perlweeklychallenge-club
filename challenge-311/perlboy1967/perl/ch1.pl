#!/bin/perl

=pod

The Weekly Challenge - 311
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-311#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Upper Lower
Submitted by: Mohammad Sajid Anwar

You are given a string consists of english letters only.

Write a script to convert lower case to upper and upper case to lower
in the given string.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub invertCase ($str) {
  $str =~ tr/[a-z][A-Z]/[A-Z][a-z]/r;
}

is(invertCase('pERL'),'Perl','Example 1');
is(invertCase('rakU'),'RAKu','Example 2');
is(invertCase('PyThOn'),'pYtHoN','Example 3');

done_testing;
