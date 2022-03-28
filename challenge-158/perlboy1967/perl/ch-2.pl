#!/bin/perl

=pod

The Weekly Challenge - 158
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-158/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › First Series Cuban Primes
Submitted by: Mohammad S Anwar

Write a script to compute first series Cuban Primes <= 1000. Please refer 
wikipedia page for more information.

=cut

use v5.16;

use Math::Primality qw(is_prime);

sub ccp (\$) { return 1+3*$$_[0]*($$_[0]+++1) }

my @cp;

my $k = 1;
my $p = ccp($k);
while ($p <= 1000) {
  push(@cp, $p) if (is_prime($p));
  $p = ccp($k);
}

say join(', ', @cp);

