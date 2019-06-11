#!/usr/bin/env perl

# The numbers formed by adding one to the products of the smallest primes are
# called the Euclid Numbers (see
# https://en.wikipedia.org/wiki/Euclid_number). Write a script that finds the
# smallest Euclid Number that is not prime. This challenge was proposed by
# Laurent Rosenfeld.

use 5.026;
use strict;
use autodie;
use warnings;
use List::Util qw(product);

sub main {
    for (my $n=1; ; ++$n) {
        my $euclid = euclid($n);
        unless (is_prime($euclid)) {
            say $euclid;
            return 0;
        }
    }
}

sub euclid {
    my ($n) = @_;

    return primorial($n) + 1;
}

sub primorial {
    my ($n) = @_;

    return product map {prime($_)} (1 .. $n);
}

my @primes = (2, 3);
my %primes = map {$_ => undef} @primes;

sub prime {
    my ($n) = @_;

  NUMBER:
    for (my $i = $primes[-1]+2; $n > @primes; $i += 2) {
        foreach my $prime (@primes) {
            next NUMBER if ($i % $prime) == 0;
        }
        push @primes, $i;
        $primes{$i} = undef;
    }

    return $primes[$n-1];
}

sub is_prime {
    my ($n) = @_;

    while ($primes[-1] < $n) {
        prime(@primes+1);
    }

    return exists $primes{$n};
}

main();
