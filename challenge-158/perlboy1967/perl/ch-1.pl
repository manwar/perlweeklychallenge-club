#!/bin/perl

=pod

The Weekly Challenge - 158
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-158/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Additive Primes
Submitted by: Mohammad S Anwar

Write a script to find out all Additive Primes <= 100.

 || Additive primes are prime numbers for which the sum of their
 || decimal digits are also primes.

=cut

use v5.16;

use Math::Primality qw(next_prime is_prime);
use List::Util qw(sum);

my @ap;

my $p = next_prime(1);
while ($p <= 100) {
  push(@ap, $p) if is_prime(sum(split //,$p));
  $p = next_prime($p);
}

say join(', ',@ap);
