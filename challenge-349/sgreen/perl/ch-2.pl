#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    # Initialise position
    my $x = my $y = 0;

    foreach my $move ( split //, $input_string ) {
        # Make the move
        if ( $move eq 'U' ) {
            $y++;
        }
        elsif ( $move eq 'D' ) {
            $y--;
        }
        elsif ( $move eq 'L' ) {
            $x--;
        }
        elsif ( $move eq 'R' ) {
            $x++;
        }
        else {
            die "Invalid move encountered: '$move'\n";
        }

        # If we are at the starting point, return True
        if ( $x == 0 and $y == 0 ) {
            say "true";
            return;
        }
    }

    # We never returned to the starting point
    say 'false';
}

main( $ARGV[0] );
