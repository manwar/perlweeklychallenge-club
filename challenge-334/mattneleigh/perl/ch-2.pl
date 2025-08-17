#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @data_sets = (
    [
        [ [1, 2], [3, 1], [2, 4], [2, 3] ],
        3,
        4 
    ],
    [
        [ [3, 4], [2, 3], [1, 5], [2, 5] ],
        2,
        5 
    ],
    [
        [ [2, 2], [3, 3], [4, 4] ],
        1,
        1 
    ],
    [
        [ [0, 1], [1, 0], [0, 2], [2, 0] ],
        0,
        0 
    ],
    [
        [ [5, 6], [6, 5], [5, 4], [4, 5] ],
        5,
        5 
    ]
);

print("\n");
foreach my $data_set (@data_sets){
    printf(
        "Input: \$x = %d, \$y = %d, \@points (%s)\nOutput: %d\n\n",
        $data_set->[1],
        $data_set->[2],
        join(
            ", ",
            map(
                "[" . join(", ", @{$_}) . "]",
                @{$data_set->[0]}
            )
        ),
        minimum_manhattan_distance($data_set)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a current location on a grid, as well as a list of other points,
# determine which valid point has the minimum Manhattan distance from the
# current point; a point is valid if it has the same X or Y coordinate as the
# current location, and the Manhattan distance is defined as:
#
#     $Dm = abs($Xcurr - $Xi) + abs($Ycurr - $Yi);
#
# where the points involved are the current point (Xcurr, Ycurr) and the point
# from the list is (Xi, Yi).  The index of the point with the shortest
# Manhattan distance will be returned; if two points share the same distance,
# the index of the first one observed will be returned, while -1 will be
# returned if no valid point exists in the list.
# Takes one argument:
# * A ref to a data structure that contains the list of points to examine and
#   the current set of coordinates (e.g.
#       [
#           [ [3, 4], [2, 3], [1, 5], [2, 5] ],
#           2,
#           5 
#       ]
#   )
# Returns:
# * The index of the point with the shortest Manhattan distance observed within
#   the list; if there are multiple points with the same distance, the index
#   returned will be that of the first such point observed (e.g. 3)
# * -1 if there are no valid points within the list
################################################################################
sub minimum_manhattan_distance{
    my $point_data = shift();

    my $distance;
    my $min_distance;
    my $min_index = undef;

    for my $i (0 .. $#{$point_data->[0]}){
        # Skip points that don't match at least one
        # coordinate with the current location
        next
            unless(
                ($point_data->[0][$i][0] == $point_data->[1])
                ||
                ($point_data->[0][$i][1] == $point_data->[2])
            );

        $distance = 
                abs($point_data->[0][$i][0] - $point_data->[1])
                +
                abs($point_data->[0][$i][1] - $point_data->[2]);

        # Store distance and index if this is the
        # first or if it's less than a previously seen
        # index; if this distance matches a previously
        # seen example, it will be skipped
        if(
            !defined($min_index)
            ||
            ($distance < $min_distance)
        ){
            $min_distance = $distance;
            $min_index = $i;
        }
    }

    # If valid point(s) were observed in the list,
    # return the index of the minimum seen,
    # otherwise return -1
    return(
        defined($min_index) ?
            $min_index
            :
            -1
    );

}



