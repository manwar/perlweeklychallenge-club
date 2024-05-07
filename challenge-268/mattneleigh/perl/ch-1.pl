#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @data_sets = (
    [
        [ 3, 7, 5 ],
        [ 9, 5, 7 ]
    ],
    [
        [ 1, 2, 1 ],
        [ 5, 4, 4 ]
    ],
    [
        [ 2 ],
        [ 5 ]
    ]
);

print("\n");
foreach my $data_set (@data_sets){
    printf(
        "Input: \@x = (%s)\n       \@y = (%s)\nOutput: %d\n\n",
        join(", ", @{$data_set->[0]}),
        join(", ", @{$data_set->[1]}),
        find_magic_number($data_set)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the magic number that separates two arrays of numbers, each of
# which must differ from some element in the other by the same amount, though
# the particular element with which it differs by that amount is not required
# to have the same index within the other array
# Takes one argument:
# * A ref to an array of two arrays of integers, each of which differs from
#   some element in the other by the same value (e.g.
#       [
#           [ 3, 7, 5 ],
#           [ 9, 5, 7 ]
#       ]
#   )
# Returns:
# * The value by which each element of each array differs from some element in
#   the other (e.g. 2 )
################################################################################
sub find_magic_number{

    # Sort the two arrays, grab the first element of
    # each, and return the absolute value of the
    # difference between them
    return(
        abs(
            (sort({ $a <=> $b } @{$ARG[0][0]}))[0]
            -
            (sort({ $a <=> $b } @{$ARG[0][1]}))[0]
        )
    );

}



