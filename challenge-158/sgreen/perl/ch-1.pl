#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util 'sum';

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
    my %primes          = ();
    my @additive_primes = ();

    foreach my $x ( 1 .. 100 ) {

        next if not is_prime($x);

        $primes{$x} = 1;

        # Get the sum of all the digits
        my $s = sum( split //, $x );

        if ( $primes{$s} ) {
            # It's an additive prime!
            push @additive_primes, $x;
        }
    }

    say join ', ', @additive_primes;
}

main()