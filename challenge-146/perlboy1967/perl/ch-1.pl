#!/bin/perl

=pod

The Weekly Challenge - 146
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-146/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › 10001st Prime Number
Submitted by: Mohammad S Anwar

Write a script to generate the 10001st prime number.

=cut

use v5.16;

use Math::Primality qw(next_prime);

my $N = shift // 10_001;

my ($i,$p) = (1,2);

$p = next_prime($p) while ($i++ < $N);

printf "%d'th prime = %d\n", $N, $p;
