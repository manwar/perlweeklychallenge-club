#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub isColorful {
    my ($n) = @_;
    my %subsets;
    my @digits = split //, $n;
    my @products = @digits;

    push @products, $digits[0] * $digits[1];
    push @products, $digits[1] * $digits[2];
    push @products, $digits[0] * $digits[1] * $digits[2];
    map { $subsets{$_}++ } @products;

    return !grep { $_ > 1 } values %subsets;
}

for my $n (grep { isColorful($_) } 100 .. 999) {
    say $n;
}
