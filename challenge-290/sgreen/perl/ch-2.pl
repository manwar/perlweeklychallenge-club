#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub luhn_algorithm($s) {
    # Remove any non-numeric characters, and turn it into a reversed array
    $s =~ s/[^0-9]//g;
    my @ints = ( split //, reverse $s );

    my $count = 0;
    while ( my ( $pos, $i ) = each @ints ) {
        if ( $pos % 2 == 1 ) {
            $i *= 2;
            if ( $i > 9 ) {
                $i -= 9;
            }
        }
        $count += $i;
    }

    say $count % 10 == 0 ? 'true' : 'false';
}

luhn_algorithm( $ARGV[0] );