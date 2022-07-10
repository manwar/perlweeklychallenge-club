#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum';
use Algorithm::Combinatorics 'combinations';

sub is_prime ($number) {
    # Return true or false if the number is a prime
    if ( $number < 2 ) {
        return;
    }

    foreach my $i ( 2 .. sqrt($number) ) {
        if ( $number % $i == 0 ) {
            return;
        }
    }

    # It's a prime
    return 1;
}

sub main ( $m, $n ) {
    # Retrieve a list of all prime numbers <= m
    my @primes = ();
    for ( my $i = $m ; $i > 1 ; $i-- ) {
        push @primes, $i if is_prime($i);
    }

    # Go through each combination of n length, and see if we have a solution
    my $iter = combinations( \@primes, $n );
    while ( my $c = $iter->next ) {
        if ( sum(@$c) == $m ) {
            say join ', ', @$c;
            return;
        }
    }

    # It is possible that no solution is found
    say 'No solution!';
}

main(@ARGV);
