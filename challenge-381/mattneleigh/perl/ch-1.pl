#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    [
        [ 1, 2, 3, 4 ],
        [ 2, 3, 4, 1 ],
        [ 3, 4, 1, 2 ],
        [ 4, 1, 2, 3 ]
    ],
    [
        [ 1 ]
    ],
    [
        [1, 2, 5],
        [5, 1, 2],
        [2, 5, 1]
    ],
    [
        [1, 2, 3],
        [1, 2, 3],
        [1, 2, 3]
    ],
    [
        [1, 2, 3],
        [3, 1, 2],
        [3, 2, 1]
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \@matrix = (\n%s\n                 )\nOutput: %s\n\n",
        join(
            "\n",
            map(
                "                     " . $_,
                matrix_to_strings($matrix)
            )
        ),
        validate_matrix_sequences($matrix) ?
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
# Given a square matrix (dimensions n x n) containing only integers from 1 to
# n, determine whether every row and column each contain all of the integers
# from 1 to n
# Takes one argument:
# * A ref to a 2D array that represents the matrix (e.g.
#       [
#           [ 1, 2, 3, 4 ],
#           [ 2, 3, 4, 1 ],
#           [ 3, 4, 1, 2 ],
#           [ 4, 1, 2, 3 ]
#       ]
#   )
# Returns:
# * 0 if the matrix does not meet the criteria specified above
# * 1 if the matrix meets the criteria specified above (as it would in the
#   provided example)
################################################################################
sub validate_matrix_sequences{
    my $matrix = shift();

    # Set up a number that, in binary, has a 1 in
    # every bit position to which 0x01 can be
    # left-shifted by every value from 1 to n,
    # inclusive (e.g.  if n = 3, $bits_initial
    # will be 0x0E or 00001110b)
    my $bits_initial = (2 ** ($#$matrix + 1) - 1) << 1;
    my $i;
    my $row_bits; 
    my $col_bits; 

    # Loop over every index in the range from 0
    # to n-1
    for my $k (0 .. $#$matrix){
        $row_bits = $bits_initial;
        $col_bits = $bits_initial;

        # Loop over every index in the same range,
        # examining the contents of both the row and
        # the column that have $k as a coordinate
        for $i (0 .. $#$matrix){
            # Turn off the bit in the position designated
            # for the value stored at each position
            # defined by ($k, $i) and ($i, $k)
            $row_bits &= ~(0x01 << $matrix->[$k][$i]);
            $col_bits &= ~(0x01 << $matrix->[$i][$k]);
        }

        # If either the row or column bit values for
        # this value of $k is not 0x00, one of the
        # expected integer values was not seen, so we
        # indicate the validation has failed
        return(0)
            if($row_bits || $col_bits);
    }

    # All the expected values were seen in the
    # required places-this matrix passes
    # validation
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

    # Make a printf() format that will
    # accommodate the longest value, textually
    # speaking, in the matrix
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
                    # 1: Make a formatted string of uniform
                    # length out of each matrix value in the row
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



