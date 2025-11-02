#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my @peaks = ();

    # Check first element
    if ( $ints[0] > $ints[1] ) {
        push @peaks, 0;
    }

    # Check middle elements
    foreach my $pos ( 1 .. $#ints - 1 ) {
        if (    $ints[$pos] > $ints[ $pos - 1 ]
            and $ints[$pos] > $ints[ $pos + 1 ] )
        {
            push @peaks, $pos;
        }
    }

    # Check last element
    if ( $ints[-1] > $ints[-2] ) {
        push @peaks, $#ints;
    }

    # Print list of peak positions
    say "(", join( ", ", @peaks ), ")";
}

main(@ARGV);
