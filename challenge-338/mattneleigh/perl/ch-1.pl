#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################
my @matrices = (
    [
        [4,  4, 4, 4],
        [10, 0, 0, 0],
        [2,  2, 2, 9]
    ],
    [
        [1, 5],
        [7, 3],
        [3, 5]
    ],
    [
        [1, 2, 3],
        [3, 2, 1]
    ],
    [
        [2, 8, 7],
        [7, 1, 3],
        [1, 9, 5]
    ],
    [
        [10, 20,  30],
        [5,  5,   5],
        [0,  100, 0],
        [25, 25,  25]
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \@matrix = (\n%s\n                 )\nOutput: %d\n\n",
        join(
            "\n",
            map(
                "                      " . $_,
                matrix_to_strings($matrix)
            )
        ),
        max_row_sum($matrix)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a matrix of numerical data, find the maximum among the sums of all the
# values in each row
# Takes one argument:
# * A ref to a 2D array representing a matrix (e.g.
#       [
#           [10, 20,  30],
#           [5,  5,   5],
#           [0,  100, 0],
#           [25, 25,  25]
#       ]
#   )
# Returns
# * The maximum among the sums of all the values in each row (e.g. 100)
################################################################################
sub max_row_sum{
    use List::Util qw(sum max);

    return(
        # 2) Find the maximum among the row-sums
        max(
            map(
                # 1) Sum all the members of each row
                sum(@{$_}),
                @{shift()}
            )
        )
    );

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



