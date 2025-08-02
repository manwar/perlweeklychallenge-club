#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Check we an even number of items
    if ( $#ints % 2 == 0 ) {
        die "Please provide an even number of items!\n";
    }

    # Sort the lists
    @ints = sort { $a <=> $b } @ints;

    for ( my $i = 0 ; $i <= $#ints ; $i += 2 ) {
        # Switch the pairs of numbers around
        ( $ints[$i], $ints[ $i + 1 ] ) = ( $ints[ $i + 1 ], $ints[$i] );
    }

    # Print the result
    say '(', join( ', ', @ints ), ')';
}

main(@ARGV);