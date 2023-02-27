#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@times) {
    # Let the default shortest time be something larger than everything
    my $shortest = 24 * 60;

    # Convert the times into minutes after midnight
    my @minutes = map { substr( $_, 0, 2 ) * 60 + substr( $_, 3, 2 ) } @times;

    # Find all pairs
    foreach my $t1 ( 0 .. $#minutes - 1 ) {
        foreach my $t2 ( $t1 + 1 .. $#minutes ) {
            my $diff = abs( $minutes[$t1] - $minutes[$t2] );

            # If the difference is more than 12 hours, it will be shorter
            #  if we cross midnight
            if ( $diff > 12 * 60 ) {
                $diff = 24 * 60 - $diff;
            }

            if ( $diff < $shortest ) {
                # We have found a new shortest span
                $shortest = $diff;
            }
        }
    }

    # Print the shortest span
    say $shortest;
}

main(@ARGV);