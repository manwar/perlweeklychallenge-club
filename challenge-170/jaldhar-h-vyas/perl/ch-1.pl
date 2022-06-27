#!/usr/bin/perl
use 5.030;
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

sub nextPrime {
    state $i = 1;
    if (scalar @_) {
        $i = shift;
    }

    while ($i++) {
        if (isPrime($i)) {
            return $i;
        }
    }
}

my @primorials = (1);
my $n = 1;

until (scalar @primorials == 10) {
    push @primorials, $n *= nextPrime();
}

say join q{, }, @primorials;

