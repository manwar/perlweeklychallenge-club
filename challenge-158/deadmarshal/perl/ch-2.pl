#!/usr/bin/env perl
use strict;
use warnings;
use Math::Prime::Util qw(is_prime);

sub cuban_primes {
  my ($n) = @_;
  my @primes;
  for (my $i = 1; ; ++$i) {
    my $p = 3 * $i * ($i + 1) + 1;
    if (is_prime($p)) {
      last if $p > $n;
      push @primes, $p;
    }
  }
  return @primes;
}

print "$_ " foreach cuban_primes(1000);
