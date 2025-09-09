#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

=pod

=head1 NAME

ch-2.pl - Perl Weekly Challenge 334, Task 2: Nearest Valid Point

=head1 DESCRIPTION

Given a current location (x, y) and a list of points, find the index of the valid point
(sharing x or y coordinate) with the smallest Manhattan distance. Return -1 if no valid points exist.

=head1 FUNCTION

=head2 nearest_valid_point

Finds the index of the valid point with the smallest Manhattan distance.

=over 4

=item * $x - Current x-coordinate
=item * $y - Current y-coordinate
=item * @points - Array of points, each point is [x, y]

=back

Returns: Index of the closest valid point, or -1 if none exist.

=cut

sub nearest_valid_point {
    my ( $x, $y, $points ) = @_;

    my $min_distance = undef;
    my $min_index    = -1;

    for my $i ( 0 .. @$points - 1 ) {
        my ( $px, $py ) = @{ $points->[$i] };

        # Check if point is valid (shares x or y coordinate)
        next unless $px == $x || $py == $y;

        # Calculate Manhattan distance
        my $distance = abs( $px - $x ) + abs( $py - $y );

        # Update min distance and index if this distance is smaller
        if ( !defined $min_distance || $distance < $min_distance ) {
            $min_distance = $distance;
            $min_index    = $i;
        }
    }

    return $min_index;
}

# Test cases
is( nearest_valid_point( 3, 4, [ [ 1, 2 ], [ 3, 1 ], [ 2, 4 ], [ 2, 3 ] ] ),  2, "Test Case 1" );
is( nearest_valid_point( 2, 5, [ [ 3, 4 ], [ 2, 3 ], [ 1, 5 ], [ 2, 5 ] ] ),  3, "Test Case 2" );
is( nearest_valid_point( 1, 1, [ [ 2, 2 ], [ 3, 3 ], [ 4, 4 ] ] ),           -1, "Test Case 3" );
is( nearest_valid_point( 0, 0, [ [ 0, 1 ], [ 1, 0 ], [ 0, 2 ], [ 2, 0 ] ] ),  0, "Test Case 4" );
is( nearest_valid_point( 5, 5, [ [ 5, 6 ], [ 6, 5 ], [ 5, 4 ], [ 4, 5 ] ] ),  0, "Test Case 5" );

done_testing();
