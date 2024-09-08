#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub making_change( $remaining, $last_coin ) {
    my $combinations = 0;

    foreach my $coin ( 1, 5, 10, 25, 50 ) {
        if ( $last_coin and $last_coin < $coin ) {
            # We can't use a larger coin that the last one
            next;
        }

        if ( $coin == $remaining ) {
            # We have found a solution
            $combinations++;
        }

        if ( $coin < $remaining ) {
            # Call the function again, taking away the value of the coin
            $combinations += making_change( $remaining - $coin, $coin );
        }
    }

    # This value is returned upstream as we go
    return $combinations;
}

sub main ($change) {
    say making_change( $change, undef );
}

main( $ARGV[0] );