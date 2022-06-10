#!/bin/perl

=pod

The Weekly Challenge - 168
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-168/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Home Prime
Submitted by: Mohammad S Anwar

You are given an integer greater than 1.

Write a script to find the home prime of the given number.

In number theory, the home prime HP(n) of an integer n greater than 1 is the 
prime number obtained by repeatedly factoring the increasing concatenation of 
prime factors including repetitions.

Further information can be found on Wikipedia and OEIS.

=cut

use v5.16;
use warnings;

use Math::Prime::XS qw(is_prime);
use Math::Factor::XS qw(prime_factors);
use Try::Tiny;

# prototype(s)
sub homePrime ($);

for my $n (2 .. 1000) {
  my  $h = homePrime($n);
  printf "%d\t=> %s\n", $n, (!defined $h ? 'Too big to handle' : $h);
}

sub homePrime ($) {
  my ($n) = @_;

  try { $n  = join '', prime_factors($n) while (!is_prime($n)) }
  catch { return };

  return $n;
}
