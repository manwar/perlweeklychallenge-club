#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub is_prime {
    my $number = shift;
    foreach my $i ( 2 .. sqrt($number) ) {
        if ( $number % $i == 0 ) {
            return 0;
        }
    }

    # One is not a prime, every other number is
    return $number == 1 ? 0 : 1;
}

sub main {
    my $number      = 0;
    my $prime_count = 0;

    while ( $prime_count < 10001 ) {
        $number++;
        if ( is_prime($number) ) {
            $prime_count++;
        }
    }
    say $number;
}

main();
