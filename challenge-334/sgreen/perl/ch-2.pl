#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(class say);
use experimental 'signatures';

no warnings 'experimental::class';

class Point {
    field $x : param;
    field $y : param;

    method x { return $x; }
    method y { return $y; }

    method distance_to($other) {
        return abs( $x - $other->x ) + abs( $y - $other->y );
    }
}

sub main (@ints) {
    my $x           = shift @ints;    # First element is x
    my $y           = shift @ints;    # Second element is y
    my @points_list = ();
    for ( my $i = 0 ; $i < $#ints ; $i += 2 ) {
        push @points_list, [ $ints[$i], $ints[ $i + 1 ] ];
    }

    # Convert to Point objects
    my $starting_point = Point->new( x => $x, y => $y );
    my @points = map { Point->new( x => $_->[0], y => $_->[1] ) } @points_list;

    # Initialize variables to track the minimum distance and corresponding index
    my $min_distance = undef;
    my $min_index    = -1;

    for my $index ( 0 .. $#points ) {
        my $point = $points[$index];

    # Check if the point shares either x or y coordinate with the starting point
        next
          if $point->x != $starting_point->x && $point->y != $starting_point->y;

        # Calculate the distance from the starting point to the current point
        # and update the minimum distance and index if necessary
        my $distance = $starting_point->distance_to($point);
        if ( !defined($min_distance) || $distance < $min_distance ) {
            $min_distance = $distance;
            $min_index    = $index;
        }
    }

    say $min_index;
}

main(@ARGV);
