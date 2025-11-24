#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-349#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Power String
Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return the power of the given string.

|| The power of the string is the maximum length of a non-empty substring
|| that contains only one unique character.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(max);

sub powerString ($str) {
  max map { length } $str =~ /((.)\2*)/g;
}

is(powerString('textbook'),2,'Example 1');
is(powerString('aaaaa'),5,'Example 2');
is(powerString('hoorayyy'),3,'Example 3');
is(powerString('x'),1,'Example 4');
is(powerString('aabcccddeeffffghijjk'),4,'Example 5');

done_testing;
