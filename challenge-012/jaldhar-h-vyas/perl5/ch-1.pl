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

my $n = 1;
my $primorial = 1;

while (++$n) {
    if (isPrime($n)) {
        $primorial *= $n;
        my  $euclidNumber = $primorial + 1;
        if (!isPrime($euclidNumber)) {
            say $euclidNumber;
            last;
        }
    }
}