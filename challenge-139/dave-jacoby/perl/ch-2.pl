#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

# https://en.wikipedia.org/wiki/Full_reptend_prime

#  The first five long primes are: 7, 17, 19, 23, 29

use Math::BigFloat;
Math::BigFloat->accuracy(200);
my @long_primes;
for my $i ( 1 .. 50 ) {
    next unless is_long_prime($i);
    push @long_primes, $i;
}
say 'The first five Long Primes are: ', join ', ', @long_primes;

sub is_long_prime ($n ) {
    Math::BigFloat->accuracy($n*3);
    return 0 unless is_prime($n);
    my $bign = Math::BigFloat->new($n);
    my $big1 = Math::BigFloat->new(1);
    my $big  = $big1->bdiv($bign);
    $big =~ s/0+$//mix;
    my $alt = $big;
    $alt =~ s/^0\.//;

    my $l = $n - 1;
    for my $i ( 1 .. $l ) {
        my ( $f1, $f2 ) = $alt =~ m{(\d{$i})}g;
        return 0 if !defined $f2;
        return 0 if $f1 == $f2 && $i < $l;
        return 0 if $f1 != $f2 && $i == $l;
    }

    return 1;
}

sub is_prime ( $n ) {
    my @factors = factor($n);
    return scalar @factors == 1 ? 1 : 0;
}

sub factor ( $n ) {
    my @factors;
    for my $i ( 1 .. $n - 1 ) {
        push @factors, $i if $n % $i == 0;
    }
    return @factors;
}
