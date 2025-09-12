#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrix_parameter_sets = (
    [
        2, 3, [ [0, 1], [1, 1] ]
    ],
    [
        2, 2, [ [1, 1], [0, 0] ]
    ],
    [
        3, 3, [ [0, 0], [1, 2], [2, 1] ]
    ],
    [
        1, 5, [ [0, 2], [0, 4] ]
    ],
    [
        4, 2, [ [1, 0], [3, 1], [2, 0], [0, 1] ]
    ]
);

print("\n");
foreach my $matrix_parameters (@matrix_parameter_sets){
    printf(
        "Input: \$row = %d, \$col = %d, \@locations = (%s)\nOutput: %d\n\n",
        $matrix_parameters->[0],
        $matrix_parameters->[1],
        join(
            ", ",
            map(
                "[ " . join(", ", @{$_}) . " ]",
                @{$matrix_parameters->[2]}
            )
        ),
        increment_matrix_count_odds($matrix_parameters)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a set of dimensions that define a matrix (rows, columns) and a list of
# positions therein, increment by one all the values in each row and column
# specified by each position, and then count how many positions within the
# matrix hold odd values
# Takes one argument:
# * A ref to an array that contains the size of the desired matrix, and the
#   list of positions to increment (e.g. [ 2, 3, [ [0, 1], [1, 1] ] ] )
# Returns
# * The number of positions in the matrix that have odd values after
#   incrementing all the values in the rows and columns specified in the
#   specified list of positions (e.g. 6)
################################################################################
sub increment_matrix_count_odds{
    my $parameters = shift();

    my $col;
    my $row;
    my $odd_count = 0;

    # Create a matrix of zeros with the speciied
    # dimensions
    my @matrix = map(
        [ map(0, 1 .. $parameters->[1]) ],
        1 .. $parameters->[0]
    );

    # Loop over each specified location
    foreach my $location (@{$parameters->[2]}){
        # Increment each value in the specified row
        foreach $col (0 .. $parameters->[1] - 1){
            $matrix[$location->[0]][$col]++;
        }
        # Increment each value in the specified column
        foreach $row (0 .. $parameters->[0] - 1){
            $matrix[$row][$location->[1]]++;
        }
    }

    # Scan the entire matrix and add to the count
    # whenever an odd value is detected
    foreach $row (0 .. $parameters->[0] - 1){
        foreach $col (0 .. $parameters->[1] - 1){
            $odd_count++
                if($matrix[$row][$col] % 2);
        }
    }

    return($odd_count);

}



