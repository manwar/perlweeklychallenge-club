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

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

sub isSmith {
    my ($n) = @_;
    my @digits = split //, $n;

    my @primeFactors;
    factorize($n, \@primeFactors);
    if (scalar @primeFactors < 2) {
        return undef;
    }

    @primeFactors = map { my @d = split //, $_; sum(\@d); } @primeFactors;

    return sum(\@digits) == sum(\@primeFactors);
}

my @smiths = ();
my $n = 1;

while (scalar @smiths < 10) {
    if (isSmith($n)) {
        push @smiths, $n;
    }
    $n++;
}

say join ", ", @smiths;