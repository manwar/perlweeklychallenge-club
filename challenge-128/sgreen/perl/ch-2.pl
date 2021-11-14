#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'max';

sub _make_time {
    # Turn a HH:MM time into minutes since midnight
    my ( $hour, $min ) = split /:/, $_[0], 2;
    return $hour * 60 + $min;
}

sub main {
    # Get the times from the input
    my @times = ( join( ' ', @_ ) =~ /((?:2[0-3]|[01][0-9]):[0-5][0-9])/g );

    # Sanity check
    die "You must provide an even amount of times" if $#times % 2 == 0;

    # Pair up the arrival and departure times
    my $offset = scalar(@times) / 2;
    my @trains = ();
    for my $pairs ( 0 .. $#times / 2 ) {
        my $arr = _make_time( $times[$pairs] );
        my $dep = _make_time( $times[ $pairs + $offset ] );

        if ( $dep < $arr ) {
            # The train spans across midnight, so add two entries
            # There are 1440 minutes in a day, so 1439 is 11:59pm
            push @trains, [ 0, $arr ], [ $dep, 1439 ];
        }
        else {
            push @trains, [ $arr, $dep ];
        }
    }

    # For each minute, figure out how many platforms are used
    my @platforms = ( (0) x 1440 );
    foreach my $train (@trains) {
        foreach my $time ( $train->[0] .. $train->[1] ) {
            $platforms[$time]++;
        }
    }

    # Display the maximum number of platforms required
    my $max_platforms = max(@platforms);
    say $max_platforms;
}

main(@ARGV);
