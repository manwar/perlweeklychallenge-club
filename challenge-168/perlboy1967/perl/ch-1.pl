#!/bin/perl

=pod

The Weekly Challenge - 168
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-168/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Perrin Prime
Submitted by: Roger Bell_West

The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is the sum of 
terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ….)

  || A Perrin prime is a number in the Perrin sequence which is also a prime number.

Calculate the first 13 Perrin Primes.

f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977]

=cut

use v5.16;
use warnings;

use Math::Prime::XS qw(is_prime);

# Prototype(s)
sub perrin ($);

my %p;
my ($n,$p) = (0,1);
while ($n < 13) {
  my $pN = perrin($p++);
  if (is_prime($pN) && !exists $p{$pN}) {
    say $pN; $p{$pN}++; $n++;
  }
}
  
sub perrin ($) {
  my ($n) = @_;

  state $p = [3, 0, 2];

  return $p->[$n] if defined $p->[$n];

  $p->[@$p] = $p->[@$p-2] + $p->[@$p-3] while (!defined $p->[$n]);

  return $p->[$n];
}
