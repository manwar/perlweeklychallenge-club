#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Sort the list
    @ints = sort { $a <=> $b } @ints;

    while ( scalar(@ints) > 1 ) {
        # Take the two highest values from the list
        my ( $x, $y ) = splice( @ints, -2 );

        if ( $x != $y ) {
            # Add difference to the list, and sort it
            @ints = sort { $a <=> $b } ( @ints, $y - $x );
        }
    }

    if ( $#ints == 0 ) {
        # Print the remaining number
        say $ints[0];
    }
    else {
        #There are no numbers remaining
        say '0';
    }
}

main(@ARGV);