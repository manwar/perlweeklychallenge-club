#!/bin/perl

=pod

The Weekly Challenge - 196
- https://theweeklychallenge.org/blog/perl-weekly-challenge-195/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Pattern 132
Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find out subsequence that respect Pattern 132. Return empty array if none found.

||  Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] < a[k] < a[j].

=cut

use v5.16;
use common::sense;

use Test::More;
use Test::Deep qw(cmp_deeply);

sub pattern132 {
  my @a = @{$_[0]};

  while (@a >= 3) {
    my $a = shift @a; my @b = @a;
    while (@b >= 2) {
      my $b = shift @b; my @c = @b;
      while (@c >= 1) {
        my $c = shift @c;
        return [$a,$b,$c] if ($a < $c and $c < $b);
      }
    }
  }
 
  return [];
}

for (
  [[3, 1, 4, 2], [1, 4, 2]],
  [[1, 2, 3, 4], []],
  [[1, 3, 2, 4, 6, 5], [1, 3, 2]],
  [[1, 3, 4, 2], [1, 3, 2]],
) {
  cmp_deeply(pattern132($_->[0]),
             $_->[1], 
             sprintf('test [%s]',join(',',@{$_->[0]})));
} 

done_testing;
