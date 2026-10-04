#!/usr/bin/perl
use 5.40.1;
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

sub nearestLowerPrimeDistance($sum) {
    my $candidate = $sum;

    while ($candidate > 1 && !isPrime($candidate)) {
        $candidate--;
    }

    return $sum - $candidate;
}

sub nearestUpperPrimeDistance($sum, $upperBound) {
    my $candidate = $sum;

    while ($candidate <= $upperBound && !isPrime($candidate)) {
        $candidate++;
    }

    return $candidate - $sum;
}

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

my ($str) = @ARGV;

my $sum = sum(map { ord } split //, $str);
my $lower = nearestLowerPrimeDistance($sum);
my $upper = nearestUpperPrimeDistance($sum, $sum + $lower);
say $lower < $upper ? $lower : $upper;
