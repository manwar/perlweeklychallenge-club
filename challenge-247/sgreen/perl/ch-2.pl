#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($string) {
    # The alphabet
    my $alphabet = join '', 'a' .. 'z';

    # Store the best result found
    my $solution    = undef;
    my $occurrences = 0;

    foreach my $i ( 0 .. 24 ) {
        # Get the two consecutive letters and the number of occurrences
        my $letters = substr( $alphabet, $i, 2 );
        my $count   = () = $string =~ /$letters/g;

        # If it is greater than the current count, store it
        if ( $count > $occurrences ) {
            $occurrences = $count;
            $solution    = $letters;
        }
    }

    say $solution // "No consecutive letters found!";
}

main( $ARGV[0] );