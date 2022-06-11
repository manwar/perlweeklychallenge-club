#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my @fibs = @_;

    # Sanity check
    if ( scalar(@fibs) != 2 ) {
        die "You must specify two inputs\n";
    }
    if ( length( $fibs[0] ) != length( $fibs[1] ) ) {
        die "Strings must be of the same length\n";
    }

    # Keep compounding the strings until we have at least 51 digits
    while ( scalar(@fibs) == 2 or length( $fibs[-1] ) < 51 ) {
        push @fibs, $fibs[-2] . $fibs[-1];
    }

    # Print the 51st character from the last string
    say substr( $fibs[-1], 50, 1 );
}

main(@ARGV);