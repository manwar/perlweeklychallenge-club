#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    [
        [1,  2,  3,  4],
        [5,  6,  7,  8],
        [9, 10, 11, 12]
    ],
    [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \$a = [\n%s\n            ]\n" .
        "Output: \$b = [\n%s\n             ]\n\n",
        join(
            ",\n",
            map(
                sprintf("               %s", $_),
                matrix_to_strings($matrix)
            )
        ),
        join(
            ",\n",
            map(
                sprintf("                %s", $_),
                matrix_to_strings(
                    submatrix_sums($matrix)
                )
            )
        ),
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a matrix, calculate the sums of the values of each 2x2 sub-matrix
# within, and produce a matrix containing those sums
# Takes one argument:
# * A ref to the matrix (e.g.
#       [
#           [  1,  2,  3,  4 ],
#           [  5,  6,  7,  8 ],
#           [  9, 10, 11, 12 ]
#       ]
#   )
# Returns:
# * A ref to a matrix containing the sums of the values in each 2x2 sub-matrix
#   within the original matrix (e.g.
#       [
#           [ 14, 18, 22 ],
#           [ 30, 34, 38 ]
#       ]
#   )
################################################################################
sub submatrix_sums{
    my $A = shift();

    my @B;

    # Loop over both sets of coordinates in the
    # matrix, from zero to their max value minus
    # one
    for my $k (0 .. $#$A - 1){
        for my $i (0 .. $#{$A->[0]} - 1){
            # Sum the four values in each 2x2 sub-matrix
            # that begins at $k, $i ('i' and 'k' being
            # reversed from typical mathematical
            # convention due to the way nested arrays
            # work)
            $B[$k][$i] =
                $A->[$k][$i] + $A->[$k][$i + 1] +
                $A->[$k + 1][$i] + $A->[$k + 1][$i + 1];
        }
    }

    return(\@B);

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



