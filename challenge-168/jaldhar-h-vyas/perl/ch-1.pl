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

my @perrins = (3, 0, 2);
my $i = 2;
my @perrinPrimes;

while (scalar @perrinPrimes < 13) {
    if (isPrime($perrins[2]) && ! grep { $_ == $perrins[2] } @perrinPrimes) {
        push @perrinPrimes, $perrins[2];
    }
    push @perrins,  $perrins[0] + $perrins[1];
    shift @perrins;
}

say join q{, }, sort {$a <=> $b} @perrinPrimes;
