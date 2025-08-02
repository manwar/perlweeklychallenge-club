#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($str) {
    # Convert the string to lower case
    $str = lc $str;

    # Start with the first letter
    my $current_key = substr( $str, 0, 1 );

    # Count the number of times we change keys
    my $changes = 0;

    foreach my $letter ( split //, $str ) {
        if ( $letter ne $current_key ) {
            # We need to change key
            $current_key = $letter;
            $changes++;
        }
    }

    say $changes;
}

main( $ARGV[0] );