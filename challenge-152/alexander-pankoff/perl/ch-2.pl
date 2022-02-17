#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

# TASK #2 › Rectangle Area
# Submitted by: Mohammad S Anwar
#
# You are given coordinates bottom-left and top-right corner of two rectangles in a 2D plane.
#
# Write a script to find the total area covered by the two rectangles.
# Example 1:
#
# Input: Rectangle 1 => (-1,0), (2,2)
#        Rectangle 2 => (0,-1), (4,4)
#
# Output: 22
#
# Example 2:
#
# Input: Rectangle 1 => (-3,-1), (1,3)
#        Rectangle 2 => (-1,-3), (2,2)
#
# Output: 25

use List::Util qw(min max);

run() unless caller();

sub run() {

    say "Running example 1";
    say rectangles_area( [ [ -1, 0 ], [ 2, 2 ] ], [ [ 0, -1 ], [ 4, 4 ] ] );
    say "Running example 2";
    say rectangles_area( [ [ -3, -1 ], [ 1, 3 ] ], [ [ -1, -3 ], [ 2, 2 ] ] );
    say "Running example without overlap";
    say rectangles_area( [ [ -1, 0 ], [ 0, 1 ] ], [ [ 1, 0 ], [ 2, 1 ] ] );
}

sub rectangles_area ( $rectangle1, $rectangle2 ) {
    say "Rectangle 1 => " . show_rectangle_corners($rectangle1);
    say "Rectangle 2 => " . show_rectangle_corners($rectangle2);

    my $area1 = rectangle_area($rectangle1);
    my $area2 = rectangle_area($rectangle2);

    my $overlap_rectangle =
      find_overlapping_rectangle( $rectangle1, $rectangle2 );

    my $overlap_area = rectangle_area($overlap_rectangle);

    return $area1 + $area2 - $overlap_area;
}

sub rectangle_area($rectangle) {
    my ( $x1, $y1, $x2, $y2 ) = map { @$_ } @$rectangle;

    my $x = abs( $x1 - $x2 );
    my $y = abs( $y1 - $y2 );

    return $x * $y;

}

sub find_overlapping_rectangle ( $rectangle1, $rectangle2 ) {
    my ( $x11, $y11, $x12, $y12 ) = map { @$_ } @$rectangle1;
    my ( $x21, $y21, $x22, $y22 ) = map { @$_ } @$rectangle2;

    my $x1 = max( $x11, $x21 );
    my $y1 = max( $y11, $y21 );

    my $x2 = min( $x12, $x22 );
    my $y2 = min( $y12, $y22 );

    if ( $x1 > $x2 || $y1 > $y2 ) {
        ## no overlap, return rectangle with empty area
        return [ [ 0, 0 ], [ 0, 0 ] ];
    }

    return [ [ $x1, $y1 ], [ $x2, $y2 ] ];
}

sub show_rectangle_corners($rectangle) {
    join( ', ', map { '(' . join( ',', @$_ ) . ')' } @$rectangle );
}
