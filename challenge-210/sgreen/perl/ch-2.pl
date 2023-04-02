#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    # Continue until we can't
  C: while (1) {
        # Go through each item in the array, get that value and the next
        foreach my $i ( 0 .. $#array - 1 ) {
            my $left  = $array[$i];
            my $right = $array[ $i + 1 ];

            # If the left value is > 0 and the right one is < 0, we have
            #  a collision
            if ( $left > 0 and $right < 0 ) {
                $right = abs($right);
                if ( $right <= $left ) {
                    # Remove the right number
                    splice( @array, $i + 1, 1 );
                }
                if ( $right >= $left ) {
                    # Remove the left number
                    splice( @array, $i, 1 );
                }

                # Start the loop again
                next C;
            }
        }

        # We've gone through the list and removed all collisions
        last;
    }

    say '(', join( ', ', @array ), ')';
}
main(@ARGV);