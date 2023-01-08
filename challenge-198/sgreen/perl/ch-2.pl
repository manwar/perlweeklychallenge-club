#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub is_prime ($number) {
    # Return true or false if the number is a prime
    return if $number < 2;

    foreach my $i ( 2 .. sqrt($number) ) {
        return if $number % $i == 0;
    }

    # It's a prime
    return 1;
}

sub main ($n) {
    # Count the number of primes
    my $count = 0;

    # Iterate from 1 to n
    foreach my $i ( 1 .. $n - 1 ) {
        # If it is a prime, add to count
        ++$count if is_prime($i);
    }

    say $count;
}

main( $ARGV[0] );