#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    [
        [ 1, 1, 0, 0, 0 ],
        [ 1, 1, 1, 1, 0 ],
        [ 1, 0, 0, 0, 0 ],
        [ 1, 1, 0, 0, 0 ],
        [ 1, 1, 1, 1, 1 ]
    ],
    [
        [ 1, 0, 0, 0 ],
        [ 1, 1, 1, 1 ],
        [ 1, 0, 0, 0 ],
        [ 1, 0, 0, 0 ]
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \$matrix = [\n%s\n                 ]\nOutput: (%s)\n\n",
        join(
            ",\n",
            map(
                "                     " . $_,
                matrix_to_strings($matrix)
            )
        ),
        join(
            ", ",
            rank_matrix_rows_by_strength($matrix)
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a matrix consisting only of ones and zeros, rank the rows of the matrix
# in order of strength, where one row is stronger than another if:
# 1) It has more 1's than the other row, or
# 2) If the number of 1's is equal between the two, it has a larger index than
#    the other
# Takes one argument:
# * A reference to the matrix to examine (e.g.
#       [
#           [ 1, 0, 0, 0 ],
#           [ 1, 1, 1, 1 ],
#           [ 1, 0, 0, 0 ],
#           [ 1, 0, 0, 0 ]
#       ]
#   )
# Returns:
# * A list of row indices in order of row strength, from weakest to strongest
#   (e.g. ( 0, 2, 3, 1 ) )
################################################################################
sub rank_matrix_rows_by_strength{

    my $j = 0;

    return(
        # 3: Make a list of just the indices from the
        # list generated in (1) and sorted in (2)
        map(
            $_->[1],
            # 2: Sort the list by count of 1's, unless the
            # counts are equal, in which case sort by
            # index
            sort(
                {
                    $a->[0] == $b->[0] ?
                        $a->[1] <=> $b->[1]
                        :
                        $a->[0] <=> $b->[0];
                }
                # 1: Make a list of the counts of 1's in each
                # row, paired with that row's index
                map(
                    [ scalar(grep($_ == 1, @{$_})), $j++ ],
                    @{$ARG[0]}
                )
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



