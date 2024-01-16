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
        [  3,  7,  8 ],
        [  9, 11, 13 ],
        [ 15, 16, 17 ]
    ],
    [
        [  1, 10,  4,  2 ],
        [  9,  3,  8,  7 ],
        [ 15, 16, 17, 12 ]
    ],
    [
        [ 7 ,8 ],
        [ 1 ,2 ]
    ],

    # Additional test case(s)
    # No Lucky Number
    [
        [ 1, 0, 0 ],
        [ 0, 1, 0 ],
        [ 0, 0, 1 ]
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \$matrix = [\n%s\n                 ];\nOutput: %d\n\n",
        join(
            ",\n",
            map(
                "                      " . $_,
                matrix_to_strings($matrix)
            )
        ),
        find_lucky_number($matrix)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a M x N matrix of distinct positive numbers, determine whether a matrix
# has a Lucky Number, and if so what that number is; a Lucky Number is an
# element that is the minimum value in its row but the maximum value in its
# column
# Takes one argument:
# * A ref to a matrix of distinct positive numbers, as an array of arrays (e.g.
#       [
#           [  3,  7,  8 ],
#           [  9, 11, 13 ],
#           [ 15, 16, 17 ]
#       ]
#   )
# Returns on success:
# * The first Lucky Number found within the matrix; if there are more than one,
#   the one in the column farthest to the left relative to the others will be
#   found first (e.g. 15)
# Returns on error:
# * -1 if no Lucky Number could be found within the matrix
################################################################################
sub find_lucky_number{
    use List::Util qw(min);

    my @row_mins;

    # Create an undef for each row in the matrix
    # (set the one at the end; the rest autovivify)
    $row_mins[$#{$ARG[0]}] = undef;

    # Loop over every column in the matrix
    for my $col (0 .. $#{$ARG[0][0]}){
        # Assign a very negative value
        my $max = -(~0x00);
        my $max_row = 0;

        # Find the maximum value in this column and
        # note the row in which it appears
        for my $row (0 .. $#{$ARG[0]}){
            if($ARG[0][$row][$col] > $max){
                $max = $ARG[0][$row][$col];
                $max_row = $row;
            }
        }

        return($max)
            if(
                # Compare the column max with the row min...
                $max
                ==
                (
                    # See if the min for this row has been
                    # calculted already; if so use it, if not,
                    # calculate it, store it, and pass the value on
                    defined($row_mins[$max_row])
                    ?
                    $row_mins[$max_row]
                    :
                    ($row_mins[$max_row] = min(@{$ARG[0][$max_row]}))
                )
            );
    }

    # Didn't find a lucky number
    return(-1);

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



