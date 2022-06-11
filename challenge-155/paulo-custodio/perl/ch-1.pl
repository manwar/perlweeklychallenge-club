#!/usr/bin/env perl

# Challenge 155
#
# TASK #1 › Fortunate Numbers
# Submitted by: Mohammad S Anwar
# Write a script to produce first 8 Fortunate Numbers (unique and sorted).
#
# According to Wikipedia
#
# A Fortunate number, named after Reo Fortune, is the smallest integer m > 1
# such that, for a given positive integer n, pn# + m is a prime number, where
# the primorial pn# is the product of the first n prime numbers.
#
# Expected Output
# 3, 5, 7, 13, 17, 19, 23, 37

use Modern::Perl;
use List::Util qw( product );
use ntheory qw( is_prime next_prime );

my %fortunate;

my @primes = (2);
while (scalar(keys %fortunate) < 8) {
    my $p = product(@primes);
    my $m = 2;
    while (!is_prime($p+$m)) {
        $m++;
    }
    $fortunate{$m} = 1;

    push @primes, next_prime($primes[-1]);
}

say join(", ", sort {$a<=>$b} keys %fortunate);
