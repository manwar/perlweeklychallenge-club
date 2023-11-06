#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 241 Task 2: Prime Order
#
#       Perl solution by Matthias Muth.
#

use v5.20;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use lib '.';
use TestExtractor;

sub n_prime_factors( $n ) {
    my $n_prime_factors = 0;
    for ( my $i = 2; $i <= $n; ++$i ) {
        if ( $n % $i == 0 ) {
            $n /= $i;
            ++$n_prime_factors;
            redo;
        }
    }
    return $n_prime_factors;
}

sub prime_order( @int ) {
    my @n_prime_factors = map n_prime_factors( $_ ), @int;
    return @int[
        sort {
            $n_prime_factors[$a] <=> $n_prime_factors[$b]
                || $int[$a] <=> $int[$b]
        } 0..$#int
    ];
}

run_tests;
