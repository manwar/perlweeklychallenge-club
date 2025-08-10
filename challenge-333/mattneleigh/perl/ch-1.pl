#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @coordinate_sets = (
    [
        [ 2, 1 ], [ 2, 3 ], [ 2, 5 ]
    ],
    [
        [ 1, 4 ], [ 3, 4 ], [ 10, 4 ]
    ],
    [
        [ 0, 0 ], [ 1, 1 ], [ 2, 3 ]
    ],
    [
        [ 1, 1 ], [ 1, 1 ], [ 1, 1 ]
    ],
    [
        [ 1000000, 1000000 ], [ 2000000, 2000000 ], [ 3000000, 3000000 ]
    ]
);

print("\n");
foreach my $coordinate_set (@coordinate_sets){
    printf(
        "Input: \@list = (%s)\nOutput: %s\n\n",
        join(
            ", ",
            map(
                "[" . join(", ", @{$_}) . "]",
                @{$coordinate_set}
            )
        ),
        are_colinear(@{$coordinate_set}) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a set of coordinates that define three points, determine whether these
# points make a straight line.  This is accomplished by calculating the area of
# the triangle formed by the points and determining whether it is zero; due to
# round-off error, it is possible that a set of points that are very nearly
# (but not quite) colinear may be indicated as colinear.
# Takes one argument:
# * A list of coordinates to examine (e.g. ([ 1, 4 ], [ 3, 4 ], [ 10, 4 ]) )
# Returns:
# * 0 if the points defined by the supplied coordinates do NOT appear to be
#   colinear
# * 1 if the points defined by the supplied coordinates appear to be colinear
#   (but see the note above regarding round-off error)
################################################################################
sub are_colinear{

    # Determine whether the points form a triangle with
    # an area of zero (or very close to it, considering
    # round-off error...) in which case they should be
    # colinear
    return(
        (
            0.5
            *
            abs(
                $ARG[0][0] * ($ARG[1][1] - $ARG[2][1])
                +
                $ARG[1][0] * ($ARG[2][1] - $ARG[0][1])
                +
                $ARG[2][0] * ($ARG[0][1] - $ARG[1][1])
            )
        )  < 0.000000001 ?
            1
            :
            0
    );

}



