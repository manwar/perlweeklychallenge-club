#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    [
        [ 1, 0, 0, 2 ],
        [ 0, 3, 4, 0 ],
        [ 0, 5, 6, 0 ],
        [ 7, 0, 0, 1 ]
    ],
    [
        [ 1, 2, 3 ],
        [ 4, 5, 6 ],
        [ 7, 8, 9 ]
    ],
    [
        [ 1, 0, 2 ],
        [ 0, 3, 0 ],
        [ 4, 0, 5 ]
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \$matrix = [\n%s\n                 ]\nOutput: %s\n\n",
        join(
            ",\n",
            map(
                "                     " . $_,
                matrix_to_strings($matrix)
            )
        ),
        is_X_matrix($matrix) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a matrix of integers is an X matrix- a square matrix in
# which all the values along the major diagonals are non-zero, and all other
# values are zero
# Takes one argument:
# * A ref to a 2D array that acts as a square matrix of integers (e.g.
#       [
#           [ 1, 0, 0, 2 ],
#           [ 0, 3, 4, 0 ],
#           [ 0, 5, 6, 0 ],
#           [ 7, 0, 0, 1 ]
#       ]
#   )
# Returns:
# * 0 if the supplied matrix is not an X matrix
# * 1 if the supplied matrix is an X matrix
################################################################################
sub is_X_matrix{
    my $matrix = shift();

    # Examine every cell in the matrix at
    # coordinates i, j ($matrix->[$j][$i]
    # because of how arrays work)
    foreach my $j (0 .. $#$matrix){
        foreach my $i (0 .. $#$matrix){
            if(($i == $j) || ($i == ($#$matrix - $j))){
                # We're on one of the diagonals- this
                # must not be zero
                return(0)
                    unless($matrix->[$j][$i]);
            } else{
                # We're not on either diagonal- this
                # must be zero
                return(0)
                    if($matrix->[$j][$i]);
            }
        }
    }

    # If we got here, we had an X matrix
    return(1);

}



################################################################################
# Given a matrix, produce a set of strings of uniform length and formatting
# containing the contents of the matrix
# Takes one argument:
# * A ref to the matrix (e.g.
#       [
#           [ 4,  2 ],
#           [ 1, 12 ]
#       ]
#   )
# Returns:
# * A list of strings describing the contents of the matrix with uniform length
#   and formatting (e.g.
#       (
#           "[  4,  2 ]",
#           "[  1, 12 ]"
#       )
#   )
# Note that strings returned by this function will have square brackets at each
# end, but will neither have commas nor carriage returns to separate the
# rows in printed output, nor will they contain spaces for indenting; if the
# calling code requires any of these, it must provide them itself.
################################################################################
sub matrix_to_strings{
    use List::Util qw(max);

    # Make a printf() format that will accommodate
    # the longest value, textually speaking, in
    # the matrix
    my $value_format =
        "%"
        .
        # 3: Get the longest length amongst all the
        # rows
        max(
            map(
                # 2: Get the longest length in each row
                max(
                    # 1: Get the textual length for each value
                    map(length($_), @{$_})
                ),
                @{$ARG[0]}
            )
        )
        .
        "d";

    return(
        # 4: Make a list of lines of text containing
        # the contents of all matrix rows
        map(
            # 3: Put square brackets around each row
            sprintf(
                "[ %s ]",
                # 2: Make a string of uniform length out of
                # each matrix row
                join(
                    ", ",
                    # 1: Make a formatted string of uniform length
                    # out of each matrix value in the row
                    map(
                        sprintf($value_format, $_),
                        @{$_}
                    )
                )
            ),
            @{$ARG[0]}
        )
    );

}



