#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'sum';

sub main ( $input_string, $k ) {
    my $alphabet = join( "", "a" .. "z" );
    my $digits   = '';

    foreach my $letter ( split //, $input_string ) {
        my $idx = index( $alphabet, $letter );
        if ( $idx == -1 ) {
            # Handle the case where we have unexpected input
            die
              "The character '$letter' does not appear to be a lower case letter\n";
        }

        # Concatenate the 1-based index of the letter
        $digits .= $idx + 1;
    }

    # Repeat this step k times
    foreach ( 1 .. $k ) {
        # Calculate the sum of all the digits
        $digits = sum( split //, $digits );
    }

    say $digits;
}

main(@ARGV);
