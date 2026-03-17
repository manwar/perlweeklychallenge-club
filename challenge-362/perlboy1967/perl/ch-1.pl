#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-362#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Echo Chamber
Submitted by: Mohammad Sajid Anwar

You are given a string containing lowercase letters.

Write a script to transform the string based on the index position of each
character (starting from 0). For each character at position i, repeat it i + 1 times.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub echoChamber ($str) {
  my $i = 1;
  return join '', map { $_ x $i++ } split //, $str;
}

is(echoChamber('abca'),'abbcccaaaa','Example 1');
is(echoChamber('xyz'),'xyyzzz','Example 2');
is(echoChamber('code'),'coodddeeee','Example 3');
is(echoChamber('hello'),'heelllllllooooo','Example 4');
is(echoChamber('a'),'a','Example 5');

done_testing;
