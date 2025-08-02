#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Take the first two integers to seed each array
    my @arr1 = ( shift @ints );
    my @arr2 = ( shift @ints );

    while ( scalar(@ints) ) {
        # If the lasst element in the first list is greater than the last
        #  element in the second list
        if ( $arr1[-1] > $arr2[-1] ) {
            # ... add it to the first list
            push @arr1, shift @ints;
        }
        else {
            # ... else add it to the second list
            push @arr2, shift @ints;

        }
    }

    # Join the arrays together
    say '(', join( ', ', @arr1, @arr2 ), ')';
}

main(@ARGV);