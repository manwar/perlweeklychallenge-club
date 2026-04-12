#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'uniq';

sub main ( $number, $mode ) {
    # List of prime factors for the number
    my @factors = ();

    # The first prime is two
    my $i = 2;

    # Calculate prime factors
    while ( $number > 1 ) {
        if ( $number % $i == 0 ) {
            # i is a prime factor. Add it to the list, and evaluate it again
            push @factors, $i;
            $number /= $i;
        }
        else {
            # Not a prime factor, evaluate the next number
            $i++;

            # Safety valve
            if ( $i > $number ) {
                die "Cannot calculate prime digits\n";
            }
        }
    }

    # Return the number of prime factors (mode = 1), or unique primes (mode = 0)
    say $mode ? scalar(@factors) : scalar( uniq @factors );
}

main(@ARGV);
