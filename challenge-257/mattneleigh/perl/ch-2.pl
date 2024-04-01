#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    [
        [ 1, 1, 0 ],
        [ 0, 1, 0 ],
        [ 0, 0, 0 ]
    ],
    [
        [ 0, 1,-2, 0, 1 ],
        [ 0, 0, 0, 1, 3 ],
        [ 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0 ]
    ],
    [
        [ 1, 0, 0, 4 ],
        [ 0, 1, 0, 7 ],
        [ 0, 0, 1,-1 ]
    ],
    [
        [ 0, 1,-2, 0, 1 ],
        [ 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 1, 3 ],
        [ 0, 0, 0, 0, 0 ]
    ],
    [
        [ 0, 1, 0 ],
        [ 1, 0, 0 ],
        [ 0, 0, 0 ]
    ],
    [
        [ 4, 0, 0, 0 ],
        [ 0, 1, 0, 7 ],
        [ 0, 0, 1,-1 ]
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \$M = [\n%s\n            ]\nOutput: %d\n\n",
        join(
            ",\n",
            map(
                "                 " . $_,
                matrix_to_strings($matrix)
            )
        ),
        matrix_in_rref($matrix)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a matrix is in Reduced Row Echelon Form (RREF)
# Takes one argument:
# * A ref to a matrix, in the form of an array of arrays of integers (e.g.
#       [
#           [ 1, 0, 0, 1 ],
#           [ 0, 1, 0, 2 ],
#           [ 0, 0, 1, 3 ]
#       ]
#   )
# Returns:
# * 1 if the matrix is in RREF
# * 0 if the matrix is NOT in RREF
# For more about this form of matrix, see:
# https://en.wikipedia.org/wiki/Row_echelon_form
################################################################################
sub matrix_in_rref{
    my $matrix = shift();

    my $prev_all_zero_row = undef;
    my $prev_nonzero_col = undef;

    # Examine each row of the matrix (coordinate $j)
    for my $j (0 .. $#$matrix){
        my $row = $matrix->[$j];
        my $nonzero_col = undef;

        # Examine each column of the row (coordinate $i)
        # to find the first nonzero element
        for my $i (0 .. $#$row){
            if($row->[$i]){
                # This is a non-zero element...

                # If it's not 1, we aren't in RREF
                return(0)
                    unless($row->[$i] == 1);

                # Note where this 1 is, and break out of the
                # loop
                $nonzero_col = $i;
                last;
            }
        }

        if(defined($nonzero_col)){
            # This row was not all zeros...

            # If there was a previous all-zero row; we
            # aren't in RREF
            return(0)
                if(defined($prev_all_zero_row));

            # If there has been a previous row with a
            # leading 1 but the current leading 1 is not to
            # the right of the previous one, we aren't in
            # RREF
            return(0)
                if(
                    defined($prev_nonzero_col)
                    &&
                    ($prev_nonzero_col >= $nonzero_col)
                );

            # See if anything else in this column isn't a
            # zero... use alternate row coordinate $J, 
            # skipping the current row $j
            for my $J ((0 .. ($j - 1)), (($j + 1) .. $#$matrix)){
                # If something else in this column isn't zero,
                # we aren't in RREF
                return(0)
                    if($matrix->[$J][$nonzero_col]);
            }

            # Make a note of the column in which the first
            # not-zero in this row appeared
            $prev_nonzero_col = $nonzero_col;
        } else{
            # This row was all zeros- make a note of this
            $prev_all_zero_row = $j;
        }
    }

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



