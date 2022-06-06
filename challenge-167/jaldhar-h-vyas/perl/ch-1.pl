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

my @circularPrimes;
my $n = 99;

outer: while (scalar @circularPrimes < 10) {
    $n++;

    unless ($n =~ /^[1379]+$/) {
        next;
    }

    my $rotated = $n;
    for (0 .. length $n) {
        unless (isPrime($rotated) && ! grep { $_ == $rotated } @circularPrimes) {
            next outer;
        }

        $rotated = substr($rotated, 1) . substr($rotated, 0, 1);
    }
    push @circularPrimes, $n;
}

say join q{, }, @circularPrimes;
