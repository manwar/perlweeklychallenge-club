#!/bin/perl

=pod

The Weekly Challenge - 312
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-312#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Minimum Time
Submitted by: Mohammad Sajid Anwar

You are given a typewriter with lowercase english letters a to z arranged in a circle.

Typing a character takes 1 sec. You can move pointer one character clockwise or anti-clockwise.

The pointer initially points at a.

Write a script to return minimum time it takes to print the given string.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use List::Util qw(min);

sub minimumTime ($str) {
  my ($dt,$cur) = (length($str),'a');
  for (split(//,lc($str))) {
    if ($cur ne $_) {
      my $d = abs(ord($_)-ord($cur));
      $dt += min($d,26-$d);
      $cur = $_;
    }
  }
  return $dt; 
}

is(minimumTime('abc'),5,'Example 1');
is(minimumTime('bza'),7,'Example 2');
is(minimumTime('zjpc'),34,'Example 3');
is(minimumTime('bzza'),8,'Own Example');

done_testing;
