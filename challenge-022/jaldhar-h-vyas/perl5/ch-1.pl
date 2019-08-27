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

my @sexyPrimes;

while (scalar @sexyPrimes < 10) {
    my $p = nextPrime();
    if (isPrime($p + 6)) {
        push @sexyPrimes, [$p, $p + 6];
    }
}

for my $sp (@sexyPrimes) {
    say "$sp->[0], $sp->[1]";
}