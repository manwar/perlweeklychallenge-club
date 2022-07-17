#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($n) {
    # The first character is 0 .. len(n)-2
    foreach my $i ( 0 .. length($n) - 2 ) {
        # Calculate the difference between that number and the next
        my $diff = abs( substr( $n, $i, 1 ) - substr( $n, $i + 1, 1 ) );
        if ( $diff != 1 ) {
            # This is not a esthetic number
            say '0';
            return;
        }
    }

    # This is a esthetic number
    say '1';
}

main(@ARGV);