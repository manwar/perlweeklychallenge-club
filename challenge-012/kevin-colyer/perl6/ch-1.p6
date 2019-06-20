#!/usr/bin/perl6
use v6;

use Test;

# 12.1
my @primes = lazy (2,3,*+2 ... ∞).grep: *.is-prime;

# from wikipedia: https://en.wikipedia.org/wiki/Euclid_number
# Write a script that finds the smallest Euclid Number that is not prime

for ^∞ -> $n {
    my $i = ( [*] @primes[0..$n] ) + 1;
    if ! $i.is-prime {
        say "12.1) (first $n primes + 1) -> $i is not prime";
        last;
    }
};

