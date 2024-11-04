#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-293#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Similar Dominos
Submitted by: Mohammad Sajid Anwar

You are given a list of dominos, @dominos.

Write a script to return the number of dominoes that are similar to any
other domino.

|| $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either
|| (a = c and b = d) or (a = d and b = c).


=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

use List::Util qw(sum);

no warnings qw(experimental::signatures);
sub similarDominos ($arDominos) {
  my %d;
  map { $d{ join ':', sort { $a <=> $b } @$_}++ } @$arDominos;
  sum map { $d{$_} > 1 ? $d{$_} : 0 } keys %d;
}

is(2,similarDominos([[1,3],[3,1],[2,4],[6,8]]),'Example 1');
is(3,similarDominos([[1,2],[2,1],[1,1],[1,2],[2,2]]),'Example 2');
is(5,similarDominos([[1,2],[2,1],[1,2],[2,3],[3,2]]),'Own test');

done_testing;
