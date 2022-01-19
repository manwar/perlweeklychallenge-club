#!/usr/bin/perl
use 5.020;
use warnings;

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

my @primes;
my $n = 2;

while (scalar @primes < 20) {
    if ($n !~ /0/ && isPrime($n)) {
        my $candidate = $n;

        while (length $candidate && isPrime($candidate)) {
            $candidate = substr $candidate, 1;
        }

        if (length $candidate == 0) {
            push @primes, $n;
        }
    }
    $n++;
}

say join q{, }, @primes;
