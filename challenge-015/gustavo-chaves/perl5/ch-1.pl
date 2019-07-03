#!/usr/bin/env perl

# Write a script to generate first 10 strong and weak prime numbers.

use 5.026;
use strict;
use warnings;

my @primes = (2, 3);

my $strong = 0;
my $weak = 0;

TRY:
for (my $i=$primes[-1]+1; $strong < 10 || $weak < 10; ++$i) {
    for my $prime (@primes) {
        next TRY if ($i % $prime) == 0;
    }
    push @primes, $i;
    if ($primes[-2] > ($primes[-3]+$primes[-1])/2) {
        ++$strong;
        say "strong($strong) = $primes[-2]" if $strong <= 10;
    } elsif ($primes[-2] < ($primes[-3]+$primes[-1])/2) {
        ++$weak;
        say "  weak($weak) = $primes[-2]" if $weak <= 10;
    }
}
