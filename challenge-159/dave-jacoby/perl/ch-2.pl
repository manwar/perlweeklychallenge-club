#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use utf8;

for my $n ( 1 .. 50 ) {
    my $μ = möbius($n);
    print join " ", "  " , map { sprintf '%2d', $_ } $n, $μ;
    say '' if $n % 10 == 0;
}

sub möbius ($n) {
    my @primes = prime_factors($n);
    my %primes;

    # has squared prime factor
    map { $primes{$_}++ } @primes;
    for my $k ( keys %primes ) {
        return 0 if $primes{$k} > 1;
    }

    # square-free
    my $p = scalar @primes;
    return $p % 2 == 0 ? 1 : -1;
}

sub prime_factors( $n ) {
    my @primes;
    my $nn = $n;
    for my $i ( 2 .. $n ) {
        while ( $nn % $i == 0 ) {
            $nn = $nn / $i;
            push @primes, $i;
        }
    }
    return @primes;
}
