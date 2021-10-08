#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use List::Util qw{ sum };

my @primes = (2, 3, 5);

sub prime_factors {
    my ($n) = @_;

    my $p = $primes[-1] + 2;
    while ($p < 1 + $n / 2) {
        push @primes, $p unless grep 0 == $p % $_, @primes;
        $p += 2;
    }

    my $m = $n;
    my @factors;
    for my $p (@primes) {
        if (0 == $m % $p) {
            $m /= $p;
            push @factors, $p;
            redo
        }
    }
    return @factors
}

sub smith_numbers {
    my ($count) = @_;
    my @smith;
    my $n = 4;
    while (@smith < $count) {
        my @factors = prime_factors($n);
        next unless @factors > 1;

        push @smith, $n
            if sum(split //, join "", @factors) == sum(split //, $n);
    } continue {
        ++$n;
    }
    return @smith
}

use Test2::V0;
plan 1;

is [smith_numbers(10)], [4, 22, 27, 58, 85, 94, 121, 166, 202, 265];
