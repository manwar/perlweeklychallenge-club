#!/usr/bin/env perl

use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

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

sub main {
    my @solutions = (1);
    my $value     = 1;
    my $counter   = 0;

    # We need 10 solutions
    while ( @solutions < 10 ) {
        $counter++;
        if ( is_prime($counter) ) {
            # Multiple the solution by this number
            $value *= $counter;
            push @solutions, $value;
        }
    }

    say join ', ', @solutions;
}

main();