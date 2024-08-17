#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    [
        [ 0, 1 ],
        [ 1, 0 ]
    ],
    [
        [ 0, 0, 0 ],
        [ 1, 0, 1 ]
    ],
    [
        [ 0, 0 ],
        [ 1, 1 ],
        [ 0, 0 ]
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
        row_with_most_ones($matrix)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine which row (1-indexed) in a binary matrix (consisting solely of
# zeros and ones) contains the greatest number of ones; if multiple rows have
# the maximum count, the first such instance is reported
# Takes one argument:
# * A ref to a 2D array that forms a binary matrix (e.g.
#       [
#           [ 0, 1 ],
#           [ 1, 0 ]
#       ]
#   )
# Returns:
# * The 1-indexed row at which the largest number of ones was seen; if there
#   were multiple rows with this count, the lowest index will be returned (e.g.
#   1 )
################################################################################
sub row_with_most_ones{
    my $matrix = shift();

    my $ones;
    my @counts;

    # Examine each row of the matrix
    for my $j (0 .. $#$matrix){
        $ones = 0;

        # Count the ones in this row
        $ones = scalar(
            grep(
                1 == $_,
                @{$matrix->[$j]}
            )
        );

        # Skip ahead if we found no ones
        next
            unless($ones);

        # Store this row's position (1-indexed)
        # if we HAVEN'T seen this total of ones
        # before- we are only keeping track of
        # the first instance of each
        $counts[$ones] = [$ones, $j + 1]
            unless($counts[$ones]);
    }

    return(
        # 3. Grab the first (largest) count,
        # extracting the row at which it was
        # first seen
        (
            # 2. Sort the counts in descending
            # order
            sort(
                { $b->[0] <=> $a->[0] }
                # 1. Filter out undefined elements
                # (counts that haven't been seen)
                grep(defined, @counts)
            )
        )[0][1]
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



