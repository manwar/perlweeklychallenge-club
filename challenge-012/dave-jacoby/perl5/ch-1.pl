#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use List::Util qw{reduce};

use JSON;
my $json = JSON->new->pretty->canonical->utf8;

# The numbers formed by adding one to the products of the
# smallest primes are called the Euclid Numbers (see wiki).
# Write a script that finds the smallest Euclid Number that
# is not prime. This challenge was proposed by Laurent Rosenfeld.

#  E6 = 13# + 1 = 30031 = 59 � 509 is the first composite Euclid number.

my @primes;

while (1) {
    state $n = 0;
    $n++;
    if ( is_prime($n) ) {
        push @primes, $n;
        my $eu = 1 + reduce { $a * $b } @primes;
        if ( !is_prime($eu) ) {
            say join "\t", $n, $eu;
            say join ',', @primes;
            say join ',', factor($eu);
            last;
        }
    }
    last if $n > 100;
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
