#!/bin/perl

=pod

The Weekly Challenge - 155
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-155/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Fortunate Numbers
Submitted by: Mohammad S Anwar

Write a script to produce first 8 Fortunate Numbers (unique and sorted).

According to Wikipedia

 || A Fortunate number, named after Reo Fortune, is the smallest integer 
 || m > 1 such that, for a given positive integer n, pn# + m is a prime 
 || number, where the primorial pn# is the product of the first n prime numbers.

=cut

use v5.16;
use bigint;

use Math::Primality qw(next_prime);

my %fortunateNumbers;
my @primes;
my @product;

my $N = 8;

while ($N > 0) {
  push(@primes, next_prime($primes[-1] // 0));
  push(@product, $primes[-1] * ($product[-1] // 1));

  my $fN = next_prime($product[-1] + 1) - $product[-1];

  if (!exists $fortunateNumbers{$fN}) {
    $fortunateNumbers{$fN}++;
    $N--;
  }
}

say join ', ', sort { $a <=> $b } keys %fortunateNumbers;
