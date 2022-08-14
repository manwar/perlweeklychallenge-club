#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

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

sub cyclops_number ($number) {
    # Given a number return an integer of that number, a zero and the number in reverse'''
    return $number . '0' . reverse($number);
}

sub main() {
    my @solutions = ();
    my $number    = 1;

    while ( scalar(@solutions) < 20 ) {
        my $cn = cyclops_number($number);
        if ( index($number, '0') == -1 and is_prime($cn) ) {
            push @solutions, $cn;
        }

        $number++;
    }

    say join ', ', @solutions;
}

main();