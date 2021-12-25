#!/bin/perl

=pod

The Weekly Challenge - 144
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-144/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Semiprime
Submitted by: Mohammad S Anwar

Write a script to generate all Semiprime number <= 100.

For more information about Semiprime, please checkout the wikipedia page.

|| In mathematics, a semiprime is a natural number that is the product 
|| of exactly two prime numbers. The two primes in the product may equal 
|| each other, so the semiprimes include the squares of prime numbers.

=cut

use v5.16;
use strict;
use warnings;

use Math::Prime::XS qw(primes);
use Algorithm::Combinatorics qw(combinations);

sub getSemiPrimes($);

my $N = shift // 100;

printf "Semiprimes <= %d = %s\n", $N, join(',',getSemiPrimes($N));

sub getSemiPrimes($) {
  my ($n) = @_;

  my %semiPrimes;
  my @primes = primes($n/2);

  my $c = combinations(\@primes, 2);
  while (my $ar = $c->next) {
    my $product = $ar->[0] * $ar->[1];
    $semiPrimes{$product}++ if ($product <= $n);
  }

  return sort { $a <=> $b } keys %semiPrimes;
}

