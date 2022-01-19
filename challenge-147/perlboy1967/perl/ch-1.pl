#!/bin/perl

=pod

The Weekly Challenge - 147
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-147/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Truncatable Prime
Submitted by: Mohammad S Anwar

Write a script to generate first 20 left-truncatable prime numbers in base 10.

 || In number theory, a left-truncatable prime is a prime number which, in a 
 || given base, contains no 0, and if the leading left digit is successively 
 || removed, then all resulting numbers are primes.

=cut

use v5.16;

use Math::Primality qw(next_prime);

my @tPrimes;
my %primes;

my $n = 1;
do {
  $n = next_prime($n);
  $primes{$n}++;

  if (index($n,0)<0) {
    my $p = $n;
    1 while ($p =~ s#^.## && exists $primes{$p});
    push(@tPrimes,$n) if ($p eq '');
  }
} while (scalar @tPrimes < 20);

printf "%s\n", join(',',@tPrimes);
