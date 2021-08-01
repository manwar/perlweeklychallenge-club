#!/usr/bin/perl

use strict;
use warnings;
use English;
use Math::Trig ':pi';  # For the pip2 constant

# Kind of arbitrary
use constant EPSILON => 0.000001;

################################################################################
# Begin main execution
################################################################################

my @squares = (

    # This one should be a square
    [
        [10, 20], [20, 20], [20, 10], [10, 10]
    ],

    # This one should not be a square
    [
        [12, 24], [16, 10], [20, 12], [18, 16]
    ],

    # Square, rotated 45 degrees, centered
    # on the origin
    [
        [0, 10], [10, 0], [0, -10], [-10, 0]
    ],

    # Lozenge, centered on the origin
    [
        [0, 5], [15, 0], [0, -5], [-15, 0]
    ]

);
my $square;

foreach $square (@squares){
    printf(
        "%s is%s a square.\n",
        points_to_string(@{$square}),
        is_square(@{$square}) ? "" : " not"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Produce a string detailing the contents of a set of points in space
# Takes one argument:
# * A list of references to points, which in turn must each be refs to arrays
#   of numerical data describing the coordinates of each point; the list must
#   contain at least one point, e.g.:
#   @points = ([1, 3], [2, 7]);
#   points_to_string(@points);
# Returns on success:
# * A string representation of the set of points provided, e.g.:
#   "(1, 3), (2, 7)"
# Returns on error:
# * undef if the provided list is empty
################################################################################
sub points_to_string{

    my @point_strings = ();

    return(undef) unless(defined($ARG[0]));

    foreach(@ARG){
        push(
            @point_strings,
            sprintf(
                "(%s)",
                join(", ", @{$_})
            )
        );
    }

    return(join(", ", @point_strings));

}



################################################################################
# Determine if a set of points describes a square in 2D space
# Takes one argument:
# * A list of references to points which describe the vertices of a polygon,
#   which in turn must each be refs to arrays of numerical data describing the
#   X and Y coordinates of each point, e.g.:
#   @points = ([0, 0], [0, 1], [1, 1], [1, 0]);
#   is_square(@points);
#   The list must contain exactly four points or the shape described will not
#   be considered a square regardless of the location of each point
# Returns:
# * 1 if the polygon appears to be a square
# * 0 if the polygon does not appear to be a square
################################################################################
sub is_square{

    my @sides;

    # Return false if we don't have
    # exactly four points (last index is
    # 3)
    return(0) unless($#ARG == 3);

    # We have some sort of quadrilateral;
    # return false if all four sides
    # aren't the same length
    @sides = (
        points_distance($ARG[0], $ARG[1]),
        points_distance($ARG[1], $ARG[2]),
        points_distance($ARG[2], $ARG[3]),
        points_distance($ARG[3], $ARG[0]),
    );
    return(0) unless(
        # Only need to compare three times
        approx_eq($sides[0], $sides[1])
        &&
        approx_eq($sides[1], $sides[2])
        &&
        approx_eq($sides[2], $sides[3])
    );

    # We have a rhombus; return false if
    # a corner isn't a right angle (any
    # one will do)
    return(0) unless(is_right_angle($ARG[0], $ARG[1], $ARG[2]));

    # If we got here, we must have a
    # square; return true
    return(1);

}



################################################################################
# Determine whether three points in 2D space are arranged so as to form a right
# angle
# Takes three arguments:
# * A point (A) which must be a ref to an array of numerical data describing
#   the X and Y coordinates of the point
# * A point (B) which is subject to the same requirements as A; this must be
#   the vertex of the angle
# * A point (C) which is subject to the same requirements as A
# Returns:
# * 1 if ABC is a right angle
# * 0 if ABC is not a right angle
################################################################################
sub is_right_angle{
    my $a = shift();
    my $b = shift();
    my $c = shift();

    my $abs_angle = abs(points_angle($a, $b, $c));

    # Make sure the absolute value of
    # the angle is pi/2 or 3*pi/2 (pip2
    # constant from Math::Trig)
    unless(approx_eq($abs_angle, pip2) || approx_eq($abs_angle, 3 * pip2)){
        return(0);
    }

    return(1);

}



################################################################################
# Calculate the angle described by three points in 2D space
# Takes three arguments:
# * A point (A) which must be a ref to an array of numerical data describing
#   the X and Y coordinates of the point
# * A point (B) which is subject to the same requirements as A; this must be
#   the vertex of the angle
# * A point (C) which is subject to the same requirements as A
# Returns:
# * Angle ABC (B is the vertex) in radians
################################################################################
sub points_angle{
    my $a = shift();
    my $b = shift();
    my $c = shift();

    return(
        atan2($c->[1] - $b->[1], $c->[0] - $b->[0])
        -
        atan2($a->[1] - $b->[1], $a->[0] - $b->[0])
    );

}



################################################################################
# Calculate the distance between two points in 2D space
# Takes two arguments:
# * A point (A) which must be a ref to an array of numerical data describing
#   the X and Y coordinates of the point
# * A point (B) which is subject to the same requirements as A
# Returns:
# * The distance between A and B, which will never be a negative quantity
#   regardless of the relative positions of the points or the order in which
#   they were specified
################################################################################
sub points_distance{
    my $a = shift();
    my $b = shift();

    return(
        sqrt(
            ($b->[0] - $a->[0]) ** 2 + ($b->[1] - $a->[1]) ** 2
        )
    );

}



################################################################################
# Determine if two values are approximately equal (their values differ by no
# more than the pre-defined small constant EPSILON)
# Takes two arguments:
# * A numerical value (A)
# * A numerical value (B)
# Returns:
# * 1 if A and B are approximately equal
# * 0 if A and B are not approximately equal
################################################################################
sub approx_eq{
    my $a = shift();
    my $b = shift();

    return(
        abs($a - $b) > EPSILON ? 0 : 1
    );

}



