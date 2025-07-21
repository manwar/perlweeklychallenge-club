#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-330#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Clear Digits
Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and digits.

Write a script to remove all digits by removing the first digit and the closest
non-digit character to its left.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub clearDigits ($str) {
  1 while ($str =~ s#[a-z][0-9]##);
  return $str;
}

is(clearDigits('cab12'),'c','Example 1');
is(clearDigits('xy99'),'','Example 2');
is(clearDigits('pa1erl'),'perl','Example 3');
is(clearDigits('1a2b3c'),'1c','Own Example');

done_testing;
