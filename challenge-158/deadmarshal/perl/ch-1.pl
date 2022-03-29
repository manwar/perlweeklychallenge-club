#!/usr/bin/env perl
use strict;
use warnings;
use Math::Prime::Util qw(is_prime);
use List::Util qw(sum0);

sub additive_primes{
  my @arr;
  foreach(0..100){
    push @arr, $_ if is_prime($_) && is_prime(sum0 split '', "$_");
  }
  return @arr;
}

print "$_ " foreach additive_primes();
