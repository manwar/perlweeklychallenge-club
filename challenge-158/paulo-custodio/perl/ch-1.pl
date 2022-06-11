#!/usr/bin/env perl

# Challenge 158
#
# TASK #1 › Additive Primes
# Submitted by: Mohammad S Anwar
# Write a script to find out all Additive Primes <= 100.
#
# Additive primes are prime numbers for which the sum of their decimal digits
# are also primes.
#
#
# Output
# 2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89

use Modern::Perl;
use List::Util qw( sum );
use ntheory qw( is_prime next_prime );

say join(", ", additive_primes(100));

sub additive_primes {
    my($limit) = @_;
    my @out;
    my $prime = 2;
    while ($prime < $limit) {
        if (is_prime(sum(split(//, $prime)))) {
            push @out, $prime;
        }
        $prime = next_prime($prime);
    }
    return @out;
}
