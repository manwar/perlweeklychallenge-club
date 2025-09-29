#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-341#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Broken Keyboard
Submitted by: Mohammad Sajid Anwar

You are given a string containing English letters only and also you are given broken keys.

Write a script to return the total words in the given sentence can be typed completely.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub brokenKeyboard ($str,@keys) {
  my @w = split /\s+/,$str;
  return scalar @w if (@keys == 0);
  my $re = '['.join('',@keys).']';
  scalar grep !/$re/i, @w;
}

is(brokenKeyboard('Hello World',qw(d)),1,'Example 1');
is(brokenKeyboard('apple banana cherry',qw(a e)),0,'Example 2');
is(brokenKeyboard('Coding is fun',qw()),3,'Example 3');
is(brokenKeyboard('The Weekly Challenge',qw(ab)),2,'Example 4');
is(brokenKeyboard('Perl and Python',qw(p)),1,'Example 5');

done_testing;
