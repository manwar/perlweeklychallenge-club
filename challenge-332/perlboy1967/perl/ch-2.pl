#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-332#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Odd Letters
Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find out if each letter in the given string appeared odd number of times.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;
use List::MoreUtils qw(frequency all);

sub oddLetters ($str) {
  my %f = frequency(split //, $str);
  boolean all { $_ % 2 == 1 } values %f; 
}

is(oddLetters('weekly'),false,'Example 1');
is(oddLetters('perl'),true,'Example 2');
is(oddLetters('challenge'),false,'Example 3');
is(oddLetters('PerlBoy'),true,'Own example');

done_testing;
