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
while ($n++) {
    my $p = 3 * 2 ** ($n - 1) - 1;
    my $q = 3 * 2 ** ($n) - 1;
    my $r = 9 * 2 ** (2 * $n - 1) - 1;

    if (isPrime($p) && isPrime($q) && isPrime($r)) {
        say '(', (2 ** $n) * $p * $q, ', ',  (2 ** $n) * $r, ')';
        last;
    }
}