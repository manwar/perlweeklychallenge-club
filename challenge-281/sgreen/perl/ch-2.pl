#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'any';

sub convert_coord_to_list($coord) {
    my @letters = ( undef, 'a' .. 'h' );
    # 'a' is 97 in the ascii table
    return [ ord(substr( $coord, 0, 1 )) - 96, substr( $coord, 1, 1 ) ];
}

sub coord_equals ( $c1, $c2 ) {
    return $c1->[0] == $c2->[0] && $c1->[1] == $c2->[1];
}

sub main ( $start_coord, $end_coord ) {
    # Calculate the least number of knight moves between two positions

    # Check if the position is valid
    foreach my $coord ( $start_coord, $end_coord ) {
        if ( $coord !~ /^[a-h][1-8]$/ ) {
            die "The position $coord is not a valid chess coordinate!\n";
        }
    }

    # Direction the knight piece can move
    my @deltas = (
        [ 2, 1 ], [ 2, -1 ], [ -2, 1 ], [ -2, -1 ],
        [ 1, 2 ], [ 1, -2 ], [ -1, 2 ], [ -1, -2 ]
    );

    # Where we start
    my @coords = ( convert_coord_to_list($start_coord) );

    # Where we want to end
    my $target = convert_coord_to_list($end_coord);

    # Count the required moves
    my $moves = 1;

    # Co-ordinates we've already been to
    my @seen = ();

    while (1) {
        # The new coordinates after we've made the next move
        my @new_coords = ();

        # For all existing places after the previous move
        foreach my $coord (@coords) {
            # Move the knight in all possible ways
            foreach my $delta (@deltas) {
                my $new_pos =
                  [ $coord->[0] + $delta->[0], $coord->[1] + $delta->[1] ];

            # But exclude moves that take it off the board or we've already used
                if (   $new_pos->[0] < 1
                    or $new_pos->[0] > 8
                    or $new_pos->[1] < 1
                    or $new_pos->[1] > 8
                    or any { coord_equals( $new_pos, $_ ) } @seen )
                {
                    next;
                }

                if ( coord_equals( $new_pos, $target ) ) {
                    # We've hit the target position
                    say $moves;
                    return;
                }

                push @new_coords, $new_pos;
                push @seen,       $new_pos;
            }
        }

        # Looks like we'll need to move again!
        @coords = @new_coords;
        $moves++;
    }
}

main( $ARGV[0], $ARGV[1] );