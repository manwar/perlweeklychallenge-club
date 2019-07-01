#!/usr/bin/env perl

# Write a script to generate first 10 strong and weak prime numbers.
#
# For example, if the nth prime number is represented by p(n):
#
# p(1) = 2
# p(2) = 3
# p(3) = 5
# p(4) = 7
# p(5) = 11
#
# Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
# Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2
#
# In other words, a prime is "strong" if it's closer to the next
# larger prime than the next smaller prime, and it's "weak" if it's
# closer to the next smaller prime than the next larger prime.

use strict;
use warnings;
use feature 'say';
use experimental qw(signatures);

my @primes = (2, 3);
my @strong;
my @weak;

my $n = 5;
while (@strong < 10 || @weak < 10) {
    if (is_prime($n)) {
        push @primes, $n;
        my $avg = ($primes[-1] + $primes[-3]) / 2;
        if ($primes[-2] > $avg) {
            push @strong, $primes[-2];
        } elsif ($primes[-2] < $avg) {
            push @weak, $primes[-2];
        }
    }
    $n += 2;
}

$" = ", ";
say "Weak primes: @weak[0..9]";
say "Strong primes: @strong[0..9]";

sub is_prime($n) {
    for my $i (3..sqrt($n)) {
        return 0 if $n % $i == 0;
    }
    return 1;
}
