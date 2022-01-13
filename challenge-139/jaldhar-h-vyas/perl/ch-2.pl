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

sub period {
    my ($n) = @_;
    my $remainder = 1;
    my $i = 1;
    my %position;

    while (1) {
        $remainder = (10 * $remainder) % $n;
        if (exists $position{$remainder}) {
            return $i - $position{$remainder};
        }
        $position{$remainder} = $i;
        $i++;
    }
}

my $p = 2;
my @longPrimes;

while (scalar @longPrimes < 5) {
    $p++;

    unless (isPrime($p)) {
        next;
    }

    if (period($p) == $p - 1) {
        push @longPrimes, $p;
    }
}

say join q{, }, @longPrimes;
