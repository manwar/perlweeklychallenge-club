#!/bin/perl

=pod

The Weekly Challenge - 220
- https://theweeklychallenge.org/blog/perl-weekly-challenge-220

Author: Niels 'PerlBoy' van Dijke

Task 2: Squareful
Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

|| An array is squareful if the sum of every pair of adjacent elements is a perfect square.

Write a script to find all the permutations of the given array that are squareful.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep qw(cmp_deeply);

use List::MoreUtils qw(uniq slide all);
use Algorithm::Combinatorics qw(permutations);

sub _areSquareful ($$) {
  my $s = $_[0] + $_[1];
  state $c = {};
  $c->{$s} //= int($s**0.5) == $s**0.5;
  return $c->{$s};
}

sub squareful (\@) {
  my ($ar,$u,@r) = ($_[0],uniq(@{$_[0]}) == 1);

  my $iter = permutations($ar);
  while (my $arC = $iter->next) {
    push(@r,$arC) if all {$_} slide {_areSquareful($a,$b)} @$arC;
    last if (scalar @r && $u);
  }

  return @r;
}

cmp_deeply([squareful(@{[1,17,8]})],[[1,8,17],[17,8,1]]);
cmp_deeply([squareful(@{[2,2,2]})],[[2,2,2]]);

done_testing;
