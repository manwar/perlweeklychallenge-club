#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    # Is the last thing we found an 'a'
    my $last_a = 0;

    while ( $#array > -1 ) {
        # Retrieve the first character found
        my $char = shift @array;
        if ( $char == 0 ) {
            # We found an 'a'
            $last_a = 1;
        }
        elsif ( $char == 1 ) {
            # If it is 1, then we also want to remove the next character
            $last_a = 0;
            shift @array;
        }
        else {
            die "Unexpected value '$char'";
        }
    }

    say $last_a;
}

main(@ARGV);