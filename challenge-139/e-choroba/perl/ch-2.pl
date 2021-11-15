#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub prime_generator {
    my @primes;
    return sub {
        if (! @primes) {
            @primes = (2);
            return 2
        } elsif (1 == @primes) {
            push @primes, 3;
            return 3
        }

        my $candidate = $primes[-1];
      CANDIDATE:
        while (1) {
            $candidate += 2;
            for my $p (@primes) {
                next CANDIDATE if 0 == $candidate % $p;
            }
            push @primes, $candidate;
            return $candidate
        }
    }
}

sub is_long_prime {
    my ($p) = @_;
    my $inverted = '0.';
    my $dividend = 1;
    my $divisor = $p;
    my %seen;
    while ($dividend && $p + 1 >= length $inverted) {
        return $p + 1 == length $inverted ? 1 : 0 if $seen{$dividend}++;

        $dividend   *= 10;
        my $quotient = int($dividend / $divisor);
        my $rest     = $dividend % $divisor;
        $inverted   .= $quotient;
        $dividend    = $rest;
    }
    return 0
}

sub long_primes {
    my ($n) = @_;
    my @long_primes;
    my $gen = prime_generator();
    while ($n != @long_primes) {
        my $p = $gen->();
        push @long_primes, $p
            if is_long_prime($p);
    }
    return @long_primes
}

say for long_primes(5);

use Test2::V0;
plan 1;

my @LONG_PRIMES = (7, 17, 19, 23, 29, 47, 59, 61, 97, 109, 113, 131,
                   149, 167, 179, 181, 193, 223, 229, 233, 257, 263,
                   269, 313, 337, 367, 379, 383, 389, 419, 433, 461,
                   487, 491, 499, 503, 509, 541, 571, 577, 593, 619,
                   647, 659, 701, 709, 727, 743, 811, 821, 823, 857,
                   863, 887, 937, 941, 953, 971, 977, 983);

is [long_primes(60)], [@LONG_PRIMES], 'Wikipedia';
