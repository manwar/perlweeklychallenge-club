#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub time_to_minute ($s) {
    if ( $s !~ /^\d{1,2}:\d{2}$/ ) {
        die "Invalid time format, should be HH:MM\n";
    }

    my ( $hour, $minute ) = split /:/, $s;
    if ( $hour < 0 || $hour > 23 || $minute < 0 || $minute > 59 ) {
        die "Invalid time value.\n";
    }

    return $hour * 60 + $minute;
}

sub main ( $source, $target ) {
    # Convert the time to minutes past midnight, and calculate the minutes
    #  between them
    my $duration = time_to_minute($target) - time_to_minute($source);
    if ( $duration < 0 ) {
        # Adjust for next day
        $duration += 24 * 60;
    }

    # Possible increments in minutes
    my @moves = ( 60, 15, 5, 1 );
    my $count = 0;

    foreach my $move (@moves) {
        # Use as many of this move as possible
        $count += int( $duration / $move );

        # The remaining minutes
        $duration = $duration % $move;
    }

    say $count;
}

main( $ARGV[0], $ARGV[1] );
