#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub is_prime {
    my $number = shift;

    # Return true or false if the number is a prime
    return if $number < 2;

    foreach my $i ( 2 .. sqrt($number) ) {
        return if $number % $i == 0;
    }

    # It's a prime
    return 1;
}

sub is_trunc_prime {
    my $number = shift;

    if ( index( $number, '0' ) != -1 ) {
        # A left-truncatable prime cannot contain a zero
        return;
    }

    # Return true or false if the number and all it's left truncated
    #  parts is a prime. Start with the smallest figure first
    foreach my $i ( reverse 1 .. length($number) ) {
        return if not is_prime( substr( $number, $i - 1 ) );
    }

    return 1;
}

sub main {
    my @solutions = ();
    my $number    = 1;

    # Keep increasing number by one until we have twenty truncated prime
    #  numbers
    while ( @solutions < 20 ) {
        if ( is_trunc_prime($number) ) {
            push @solutions, $number;
        }
        $number++;
    }

    say join ', ', @solutions;
}

main();
