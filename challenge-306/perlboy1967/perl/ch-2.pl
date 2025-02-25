#!/bin/perl

=pod

The Weekly Challenge - 306
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-306#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 2: Last Element
Submitted by: Mohammad Sajid Anwar

You are given a array of integers, @ints.

Write a script to play a game where you pick two biggest integers in the given array,
say x and y. Then do the following:

a) if x == y then remove both from the given array
b) if x != y then remove x and replace y with (y - x)

At the end of the game, there is at most one element left.

Return the last element if found otherwise return 0.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

no warnings qw(experimental::signatures);

sub lastElement (@ints) {
  my @s = sort { $a <=> $b } @ints;
  while (@s > 1) {
    my $i = pop(@s);
    if (@s) {
      my $j = pop(@s);
      @s = sort { $a <=> $b } @s,$i-$j if ($i != $j);
      return 0 unless @s;
    } 
  }
  return $s[-1];
}

is(lastElement(3,8,5,2,9,2),1,'Example 1');
is(lastElement(3,2,5),0,'Example 2');

done_testing;
