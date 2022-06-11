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

my @padovanPrimes;
my @padovans = (1, 1, 1);
my %primeMap;

while (scalar @padovanPrimes < 10) {
    push @padovans, $padovans[0] + $padovans[1];
    shift @padovans;

    if (isPrime($padovans[2]) && !exists $primeMap{$padovans[2]}) {
        push @padovanPrimes, $padovans[2];
        $primeMap{$padovans[2]} = 1;
    }
}

say join q{, }, @padovanPrimes;