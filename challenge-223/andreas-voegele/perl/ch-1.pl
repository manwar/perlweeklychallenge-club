#!/usr/bin/perl

# You are given a positive integer, $n.  Write a script to find the total
# count of primes less than or equal to the given integer.

use 5.036;
use utf8;

# The Sieve of Eratosthenes marks the multiples of all prime numbers in an
# array.  The remaining unmarked numbers are prime numbers.

sub prime_numbers ($n) {
    my @numbers = (0, 0, 2 .. $n);
    for my $i (2 .. sqrt $n) {
        if ($numbers[$i] > 0) {
            for (my $j = $i * $i; $j <= $n; $j += $i) {
                $numbers[$j] = 0;
            }
        }
    }
    return grep { $_ > 0 } @numbers;
}

say scalar prime_numbers(10);
say scalar prime_numbers(1);
say scalar prime_numbers(20);
