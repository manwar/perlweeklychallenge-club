#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    # Given cases
    [
        [ 1, 0, 0 ],
        [ 0, 0, 1 ],
        [ 1, 0, 0 ]
    ],
    [
        [ 1, 0, 0 ],
        [ 0, 1, 0 ],
        [ 0, 0, 1 ]
    ],

    # Additional test cases
    [
        [ 1, 0, 1 ],
        [ 0, 1, 0 ],
        [ 1, 0, 1 ]
    ],
    [
        [ 1, 0, 1 ],
        [ 0, 1, 0 ],
        [ 1, 1, 0 ]
    ],
    [
        [ 1, 1, 0, 1, 1 ],
        [ 1, 0, 0, 0, 0 ],
        [ 0, 0, 1, 0, 0 ],
        [ 1, 0, 0, 0, 0 ],
        [ 1, 0, 0, 0, 0 ]
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \$matrix = [\n%s\n                 ]\nOutput: %d\n\n",
        join(
            ",\n",
            map(
                "                     " . $_,
                matrix_to_strings($matrix)
            )
        ),
        count_special_positions($matrix)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the number of Special Positions within a binary matrix, where a
# Special Position is defined as any position ($i, $j) where $matrix[$j][$i]
# (coordinates reversed because of the way nested arrays work- see below) is
# one and all other elements in the row $i and column $j are zero.
# Takes one argument:
# * A ref to an array of arrays that represent a matrix (e.g.
#       [
#           [ 1, 0, 1 ],
#           [ 0, 1, 0 ],
#           [ 1, 0, 1 ]
#       ]
#   )
# Returns:
# * The count of Special Positions within the matrix (e.g. 1 )
################################################################################
sub count_special_positions{
    my $matrix = shift();

    my $i_max = $#{$matrix->[0]};
    my $j_max = $#{$matrix};
    my @one_in_row;
    my @one_in_col;
    my $specials = 0;

    # Examine every row in the matrix
    for my $j (0 .. $j_max){
        # Skip this row if a one has already been
        # observed therein
        next
            if($one_in_row[$j]);

        # Examine every cell in this row
        for my $i (0 .. $i_max){
            # Skip this cell if a one has already
            # been observed in this column or this
            # cell is not a one
            next
                if(
                    $one_in_col[$i]
                    ||
                    !($matrix->[$j][$i])
                );

            # Scan ahead in this row for additional
            # ones
            for my $i2 ($i + 1 .. $i_max){
                if($matrix->[$j][$i2]){
                    $one_in_row[$j] = 1;
                    $one_in_col[$i2] = 1;
                }
            }

            # Scan ahead in this column for additional
            # ones
            for my $j2 ($j + 1 .. $j_max){
                if($matrix->[$j2][$i]){
                    $one_in_row[$j2] = 1;
                    $one_in_col[$i] = 1;
                }
            }

            # Increment the special count unless we
            # saw a one elsewhere in the current row
            # or col
            $specials++
                unless(
                    $one_in_col[$i]
                    ||
                    $one_in_row[$j]
                );

            # Mark this row and column as having a one
            # in case they hadn't been already
            $one_in_col[$i] = 1;
            $one_in_row[$j] = 1;
        }
    }

    return($specials);

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



