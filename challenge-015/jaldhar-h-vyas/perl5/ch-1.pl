#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub isPrime {
    my ($n) = @_;

    if ($n < 2) {
        return undef;
    }

    if ($n == 2) {
        return 1;
    }

    for my $i (2 .. sqrt($n)) {
        if ($n % $i == 0) {
            return undef;
        }
    }

    return 1;
}

sub nextPrime {
    state $i = 1;

    while ($i++) {
        if (isPrime($i)) {
            return $i;
        }
    }
}

my @primes = (nextPrime(), nextPrime());
my @strongPrimes;
my @weakPrimes;

for (my $i = 1; scalar @strongPrimes < 10 || scalar @weakPrimes < 10; $i++) {
    push @primes, nextPrime();

    my $meanOfNeighboringPrimes = ($primes[$i - 1] + $primes[$i + 1]) / 2;
    if ($primes[$i] > $meanOfNeighboringPrimes) {
        push @strongPrimes, $primes[$i];
    } elsif ($primes[$i] < $meanOfNeighboringPrimes) {
        push @weakPrimes, $primes[$i];
    }
}

say 'The 1st 10 strong Primes: ', join q{, }, @strongPrimes;
# By the time we get 10 strong primes, we will have more than 10 weak primes
# so slice off the first 10.
say 'The 1st 10 weak Primes: ',join q{, }, @weakPrimes[0 .. 9];
