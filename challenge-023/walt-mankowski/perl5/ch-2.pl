#!/usr/bin/env perl

# Create a script that prints Prime Decomposition of a given number. The
# prime decomposition of a number is defined as a list of prime numbers
# which when all multiplied together, are equal to that number. For
# example, the Prime decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3
# * 19.
#
# The code works by first finding the primes up to n using the Sieve
# of Eratosthenes, then seeing how many times each of them divide n
# evenly.

use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);

my $N = $ARGV[0];
my $n = $N;
my @p = primes_upto($n);
my @factors;
for my $p (@p) {
    while ($n % $p == 0) {
        push @factors, $p;
        $n /= $p;
    }
}
printf "%d = %s\n", $N, join "*", @factors;

# compute primes up to $n using the Sieve of Eratosthenes
sub primes_upto($n) {
    my @is_prime = map {1} (0..$n);
    $is_prime[0] = $is_prime[1] = 0;

    for my $i (2..$n) {
        if ($is_prime[$i]) {
            for (my $j = $i * 2; $j <= $n; $j += $i) {
                $is_prime[$j] = 0;
            }
        }
    }
    return grep {$is_prime[$_]} 2..$n;
}
