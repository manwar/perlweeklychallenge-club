#!/usr/bin/env perl6
use v6;

my @primes=(2..*).grep(*.is-prime);

my @strong-primes=@primes.pairs.grep({ $_.key > 0 && 2*$_.value > @primes[$_.key-1]+@primes[$_.key+1] }).map(*.value);

my @weak-primes=@primes.pairs.grep({ $_.key > 0 && 2*$_.value < @primes[$_.key-1]+@primes[$_.key+1] }).map(*.value);

say @strong-primes[0..9];
say @weak-primes[0..9];
