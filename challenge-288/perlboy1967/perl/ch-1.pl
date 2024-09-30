#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-288#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Closest Palindrome
Submitted by: Mohammad Sajid Anwar

You are given a string, $str, which is an integer.

Write a script to find out the closest palindrome, not including itself.
If there are more than one then return the smallest.

|| The closest is defined as the absolute difference minimized between two integers.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use List::Util qw(min);

sub closestPalindrome ($int) {
  my @p = ($int-1,$int+1); my @d = (-1,+1);

  for (0,1) {
    $p[$_] += $d[$_] while ($p[$_] > 0 and $p[$_] ne reverse $p[$_]);
  }

  my $minDelta = min map { abs($int-$_) } @p;

  return [@p[grep { $p[$_] - $d[$_] * $minDelta == $int } (0,1)]];
}

is(closestPalindrome(123),[121]);
is(closestPalindrome(2),[1,3]);
is(closestPalindrome(1400),[1441]);
is(closestPalindrome(1001),[999]);

done_testing;
