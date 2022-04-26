#!/usr/bin/perl
use 5.030;
use warnings;

sub factorize {
    my ($n, $primeFactors) = @_;
    if ($n < 2) {
        return;
    }

    my $p = nextPrime(1);
    while ($p <= $n) {

        if ($n % $p == 0) {
            push @{$primeFactors}, $p;
            factorize($n / $p, $primeFactors);
        }
        $p = nextPrime();
    }
}

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

sub squared {
    my ($factors) = @_;
    my %count;
    for my $factor (@{$factors}) {
        $count{$factor}++;
    }

    return (scalar grep { $count{$_} > 1} keys %count) > 0;
}

my $n = shift // die "Need a positive integer.\n";

my @factors;

factorize($n, \@factors);

if (squared(\@factors)) {
    say 0;
} else {
    say 0 + (scalar @factors % 2) ? -1 : 1;
}
