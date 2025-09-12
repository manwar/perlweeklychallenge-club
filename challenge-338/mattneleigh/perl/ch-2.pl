#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @array_pairs = (
    [
        [ 4, 5, 7 ],
        [ 9, 1, 3, 4 ]
    ],
    [
        [ 2, 3, 5, 4 ],
        [ 3, 2, 5, 5, 8, 7 ]
    ],
    [
        [ 2, 1, 11, 3 ],
        [ 2, 5, 10, 2 ]
    ],
    [
        [ 1, 2, 3 ],
        [ 3, 2, 1 ]
    ],
    [
        [ 1, 0, 2, 3 ],
        [ 5, 0 ]
    ]
);

print("\n");
foreach my $array_pair (@array_pairs){
    printf(
        "Input: \@arr1 = (%s)\n       \@arr2 = (%s)\nOutput: %d\n\n",
        join(", ", @{$array_pair->[0]}),
        join(", ", @{$array_pair->[1]}),
        max_array_difference($array_pair)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two arrays, find the maximum difference among all pairs of values, such
# that one is taken from each array
# Takes one argument:
# * A ref to a 2D array that contains the two arrays to examine (e.g.
#       [
#           [ 2, 3, 5, 4 ],
#           [ 3, 2, 5, 5, 8, 7 ]
#       ]
#   )
# Returns:
# * The maximum difference among all pair of values, such that one is taken
#   from each array (e.g. 6)
################################################################################
sub max_array_difference{
    use List::Util qw(max);

    my $n;

    return(
        # 2) Find the maximum of the differences
        max(
            # 1) Find the absolute values of the
            # differences between each element of
            # the first array and each elemwnt of 
            # the second
            map(
                {
                    $n = $_;

                    map(
                        abs($n - $_),
                        @{$ARG[0][1]}
                    );
                }
                @{$ARG[0][0]}
            )
        )
    );

}



