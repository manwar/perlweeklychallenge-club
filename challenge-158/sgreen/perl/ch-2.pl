#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub is_prime {
    my $number = shift;

    # Return true or false if the number is a prime
    return if $number < 2;

    foreach my $i ( 2 .. int( sqrt($number) ) ) {
        return if $number % $i == 0;
    }

    # It's a prime
    return 1;
}

sub main {
    my @cuban_primes = ();
    my $x            = 1;

    while ($x) {
        # Calculate 3x² + 3x + 1
        my $p = 3 * $x * $x + 3 * $x + 1;

        # We only care about values <= 1000
        last if $p > 1000;

        if ( is_prime($p) ) {
            # Add to the cuban_primes list
            push @cuban_primes, $p;
        }
        $x++;
    }
    say join ', ', @cuban_primes;
}

main()