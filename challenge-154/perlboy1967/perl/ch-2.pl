#!/bin/perl

=pod

The Weekly Challenge - 154
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-154/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Padovan Prime
Submitted by: Mohammad S Anwar

A Padovan Prime is a Padovan Number that’s also prime.

In number theory, the Padovan sequence is the sequence of integers P(n) defined by the initial values.

P(0) = P(1) = P(2) = 1

and then followed by

P(n) = P(n-2) + P(n-3)

First few Padovan Numbers are as below:

1, 1, 1, 2, 2, 3, 4, 5, 7, 9, 12, 16, 21, 28, 37, ...

Write a script to compute first 10 distinct Padovan Primes.
Expected Output

2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057

=cut

use v5.16;
use strict;

use Math::Primality qw(is_prime);

sub PadovanN($);

my ($n, $i) = (0, 0);
my %padovanPrimes;

while ($i < 10) {
  my $p = PadovanN $n++;
  if (is_prime $p  and !exists $padovanPrimes{$p}) {
    $padovanPrimes{$p}++;
    say $p; $i++;
  }
}


sub PadovanN($) {
  my ($n) = @_;
  state $p = [1,1,1];

  $p->[$n-3] //= PadovanN($n-3);
  $p->[$n-2] //= PadovanN($n-2);
  $p->[$n] = $p->[$n-2] + $p->[$n-3] if ($n > 2);

  return $p->[$n];
}
