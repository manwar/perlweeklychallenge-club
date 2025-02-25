#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @point_sets = (
    [ [1, 1], [2, 3], [3, 2] ],
    [ [1, 1], [2, 2], [3, 3] ],
    [ [1, 1], [1, 2], [2, 3] ],
    [ [1, 1], [1, 2], [1, 3] ],
    [ [1, 1], [2, 1], [3, 1] ],
    [ [0, 0], [2, 3], [4, 5] ]
);

print("\n");
foreach my $point_set (@point_sets){
    printf(
        "Input: \@points = (%s)\nOutput: %s\n\n",
        join(
            ", ",
            map(
                "[" . join(", ", @{$_}) . "]",
                @{$point_set}
            )
        ),
        is_boomerang(@{$point_set}) ?
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
# Determine whether a set of three points form a boomerang (that is to say,
# they are not colinear)
# Takes one argument:
# * A list of three points to examine (e.g. ( [1, 1], [2, 3], [3,2] ) )
# Returns
# * 0 if the points do not form a boomerang
# * 1 if the points form a boomerang (as would be the case in the example
#   above)
################################################################################
sub is_boomerang{

    return(
        # See if the slopes between points 0-1
        # and 1-2 differ
        abs(
            # Slope from point 0 to point 1; 2**53 is
            # used for vertically arranged points
            # since math gets funny if you use 'Inf'
            ($ARG[1][1] - $ARG[0][1])
            /
            (
                $ARG[1][0] == $ARG[0][0] ?
                    $ARG[1][1] > $ARG[0][1] ?
                        2**53
                        :
                        -2**53
                    :
                    $ARG[1][0] - $ARG[0][0]
            )
            -
            # Slope from point 1 to point 2
            ($ARG[2][1] - $ARG[1][1])
            /
            (
                $ARG[2][0] == $ARG[1][0] ?
                    $ARG[2][1] > $ARG[1][1] ?
                        2**53
                        :
                        -2**53
                    :
                    $ARG[2][0] - $ARG[1][0]
            )
        ) > 0.000001 ?
            1
            :
            0
    );

}



