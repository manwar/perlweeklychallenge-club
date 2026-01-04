#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    [
        [
            [ 1, 2, 3 ],
            [ 4, 5, 6 ],
            [ 7, 8, 9 ]
        ],
        1
    ],
    [
        [
            [ 10, 20 ],
            [ 30, 40 ]
        ],
        1
    ],
    [
        [
            [ 1, 2 ],
            [ 3, 4 ],
            [ 5, 6 ]
        ],
        1
    ],
    [
        [
            [ 1, 2, 3 ],
            [ 4, 5, 6 ]
        ],
        5
    ],
    [
        [
            [ 1, 2, 3, 4 ]
        ],
        1
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \@matrix = (\n%s\n                 )\n       \$k = %d\n",
        join(
            "\n",
            map(
                "                     " . $_,
                matrix_to_strings($matrix->[0])
            )
        ),
        $matrix->[1]
    );

    matrix_shift(@{$matrix});

    printf(
        "Output: (\n%s\n        )\n\n",
        join(
            "\n",
            map(
                "            " . $_,
                matrix_to_strings($matrix->[0])
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a rectangular matrix of dimensions m x n and an integer $k that is
# greater than zero, shifts the matrix $k times according ot the following
# rules:
# Rule 1:
#     Every element moves one space to the right within its row
# Rule 2:
#     Elements originally at matrix[i][n - 1] where i is in the range
#     0 .. m - 1 move to matrix[i + 1][0] except for the element originally at
#     matrix[m - 1][n - 1]...
# Rule 3:
#     The element originally at matrix[m - 1][n - 1] is moved to matrix[0][0]
# Takes two arguments:
# * A ref to the matrix to shift (e.g.
#       [
#           [ 1, 2, 3 ]
#           [ 4, 5, 6 ]
#       ]
#   )
# * The integer $k (e.g. 5)
# Returns no meaningful value.
# NOTE: This function modifies the specified matrix in place (e.g. in the case
# above, the supplied matrix would now be
#     [
#         [ 2, 3, 4 ]
#         [ 5, 6, 1 ]
#     ]
# )
################################################################################
sub matrix_shift{
    my $matrix = shift();
    my $k = shift();

    my $row;
    my @scratch;

    for(1 .. $k){
        # Apply Rule 1, storing the elements displaced from
        # the right edge of the matrix in @scratch
        @scratch = map(
            pop(@{$_}),
            @{$matrix}
        );

        # Apply Rules 2 and 3, the latter first by moving the
        # last element in @scratch to the front, then the
        # former by placing each element from @scratch at the
        # left end of each row
        unshift(@scratch, pop(@scratch));
        foreach $row (@{$matrix}){
            unshift(@{$row}, shift(@scratch));
        }
    }

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
        "s";

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



