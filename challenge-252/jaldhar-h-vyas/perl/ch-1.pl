#!/usr/bin/perl
use 5.030;
use warnings;

sub factors {
    my ($n) = @_;

    return grep { $n % $_ == 0; } 1 .. $n / 2, $n;
}

sub sum {
    my $total;
    for my $n (@_) {
        $total += $n;
    }

    return $total;
}

say sum(map { $ARGV[$_ - 1] ** 2 } factors(scalar @ARGV));