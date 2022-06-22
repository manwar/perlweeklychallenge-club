#!/bin/perl

=pod

The Weekly Challenge - 170
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-170/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Primorial Numbers
Submitted by: Mohammad S Anwar

Write a script to generate first 10 Primorial Numbers.

|| Primorial numbers are those formed by multiplying successive prime numbers.

=cut

use v5.16;
use warnings;

use Math::Primality qw(next_prime);

# Prototype(s)
sub primorialNumber ($\@);

my @p;
printf("%d\t=> %d\t(%s)\n", $_, primorialNumber($_, @p), join(',',@p)) for (0..15);


sub primorialNumber ($\@) {
  my ($i,$j) = @_;

  state $p = [1];
  state $n = [1];

  while (@$n <= $i) {
    push(@$p, next_prime($p->[-1]));
    push(@$n, $p->[-1] * $n->[-1]);
  }

  @$j = @$p[0 .. @$p-1];

  return $n->[$i];
}
