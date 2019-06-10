#!/usr/bin/perl6

use v6;

my @primes = (1...*).grep(*.is-prime);

my @euclid = (0...*).map( -> $i { ( [*] @primes[0..$i] ) + 1 } );

my @non-prime-euclid = @euclid.grep( ! *.is-prime );

say @non-prime-euclid[0];
