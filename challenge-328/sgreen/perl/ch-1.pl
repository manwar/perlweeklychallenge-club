#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    my $solution = $input_string;
    foreach my $idx ( 0 .. length($solution) - 1 ) {
        my $char = substr( $solution, $idx, 1 );
        if ( $char ne '?' ) {
            next;
        }

        # Get the surrounding characters
        my %letters = ();
        if ( $idx > 0 ) {
            $letters{ substr( $solution, $idx - 1, 1 ) } = 1;
        }
        if ( $idx < length($solution) - 1 ) {
            $letters{ substr( $solution, $idx + 1, 1 ) } = 1;
        }

        # Replace '?' with 'a', 'b', or 'c' based on surrounding characters
        if ( not exists $letters{'a'} ) {
            substr( $solution, $idx, 1 ) = 'a';
        }
        elsif ( not exists $letters{'b'} ) {
            substr( $solution, $idx, 1 ) = 'b';
        }
        else {
            substr( $solution, $idx, 1 ) = 'c';
        }
    }

    say '"', $solution, '"';
}

main( $ARGV[0] );
