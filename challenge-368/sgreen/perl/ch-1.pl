#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ( $number, $digit ) {
    # Safety check
    if ( index( $number, $digit ) == -1 ) {
        die "The digit $digit is not in $number\n";
    }

    my $max_number = 0;

    # Loop through each position
    foreach my $i ( 0 .. length($number) - 1 ) {
        if ( substr( $number, $i, 1 ) != $digit ) {
            # Don't consider removing this digit
            next;
        }

        # Make a new number without this digit, and increase max_number if necessary.
        my $new_number =  substr( $number, 0, $i ) . substr( $number, $i + 1 );
        if ( $new_number > $max_number ) {
            $max_number = $new_number;
        }
    }

    say $max_number;
}

main(@ARGV);
