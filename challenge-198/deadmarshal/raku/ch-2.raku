#!/usr/bin/env raku
use Math::Primesieve;

my $p = Math::Primesieve.new;

for [10,15,1,25] {
  say $p.primes($_).elems;
}

