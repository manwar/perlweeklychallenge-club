#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ( $str, $char ) {
    # Count the occurrences of the character in the string
    my $occurrences = 0;
    for my $pos ( 0 .. length($str) - 1 ) {
        if ( substr( $str, $pos, 1 ) eq $char ) {
            $occurrences++;
        }
    }

    # Display the percentage of occurrences
    say int( $occurrences / length($str) * 100 + 0.5 );
}

main( $ARGV[0], $ARGV[1] );