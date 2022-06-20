#!/bin/perl

=pod

The Weekly Challenge - 169
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-169/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Brilliant Numbers
Submitted by: Mohammad S Anwar

Write a script to generate first 20 Brilliant Numbers.

 || Brilliant numbers are numbers with two prime factors of the same length.

The number should have exactly two prime factors, i.e. it’s the product of two 
primes of the same length.

=cut

use v5.16;
use warnings;

use Math::Factor::XS qw(prime_factors);

# Prototype(s)
sub isBrilliantNumber($\@);

my ($n,$b,@f) = (0,1);

while ($n < 20) {
  if (isBrilliantNumber($b,@f)) {
    printf "%s => (%s)\n", $b, join(',',@f);
    $n++;
  }
  $b++;
}


sub isBrilliantNumber($\@) {
  my ($n,$arF) = @_;

  my @f = prime_factors($n);
  if (scalar @f == 2 && length($f[0]) == length($f[1])) {
    @$arF = @f;
    return 1;
  }

  return 0;
}
