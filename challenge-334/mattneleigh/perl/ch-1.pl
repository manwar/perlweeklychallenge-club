#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @data_sets = (
    [
        [ -2, 0, 3, -5, 2, -1 ],
        0,
        2
    ],
    [
        [ 1, -2, 3, -4, 5 ],
        1,
        3
    ],
    [
        [ 1, 0, 2, -1, 3 ],
        3,
        4
    ],
    [
        [ -5, 4, -3, 2, -1, 0 ],
        0,
        3
    ],
    [
        [ -1, 0, 2, -3, -2, 1 ],
        0,
        2
    ]
);

print("\n");
foreach my $data_set (@data_sets){
    printf(
        "Input: \@ints = (%s), \$x = %d, \$y = %d\nOutput: %d\n\n",
        join(", ", @{$data_set->[0]}),
        $data_set->[1],
        $data_set->[2],
        range_sum($data_set)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers and a pair of indices, compute the sum of the values
# from the list that lie between the given indices, inclusive
# Takes one argument:
# * A ref to a list that includes the list of integers and the indices over
#   which to sum values (e.g.
#       [
#           [ 1, 0, 2, -1, 3 ],
#           3,
#           4
#       ],
#   )
# Returns:
# * The sum of the values between the given indices, inclusive (e.g. 2)
################################################################################
sub range_sum{

    my $sum = 0;

    # Sum the values in an array slice corresponding
    # to the given indices
    foreach(@{$ARG[0][0]}[ $ARG[0][1] .. $ARG[0][2] ]){
        $sum += $_;
    }

    return($sum);

}



