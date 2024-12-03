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
        [ 1, 0, 1, 0, 0 ],
        [ 1, 0, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1 ],
        [ 1, 0, 0, 1, 0 ]
    ],
    [
        [ 0, 1 ],
        [ 1, 0 ]
    ],
    [
        [ 0 ]
    ],

    # Additional test cases
    [
        [ 1, 1, 1, 1, 1 ],
        [ 0, 0, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1 ],
        [ 1, 0, 0, 1, 0 ]
    ],
    [
        [ 1, 1, 1, 1, 1 ],
        [ 0, 0, 1, 0, 1 ],
        [ 1, 1, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1 ]
    ],
    [
        [ 1, 1, 0, 0, 0 ],
        [ 1, 1, 1, 1, 1 ],
        [ 0, 0, 1, 1, 1 ],
        [ 0, 0, 1, 1, 1 ]
    ],
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \@matrix = (\n%s\n                 )\nOutput: %d\n\n",
        join(
            ",\n",
            map(
                "                     " . $_,
                matrix_to_strings($matrix)
            )
        ),
        maximal_ones_square_area($matrix)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a binary matrix (one consisting of 1's and 0's only) determine the area
# of the largest square therein that consists only of 1's
# Takes one argument:
# * A ref to the matrix (e.g.
#       [
#           [ 1, 1, 1, 1, 1 ],
#           [ 0, 1, 1, 1, 1 ],
#           [ 1, 1, 1, 1, 1 ],
#           [ 1, 0, 0, 1, 0 ]
#       ]
#   )
# Returns:
# * The area of the largest square within that consists only of 1's (e.g. 9 )
################################################################################
sub maximal_ones_square_area{
    my $matrix = shift();

    my $i;
    my $j;
    my $local_i;
    my $local_j;
    my $square_size;
    my $growing;
    my $max_square = 0;

    # Loop over each coordinate in the matrix, but only
    # up to the point at which we might find a square
    # larger than any yet seen
    for $j (0 .. $#$matrix - $max_square){
        for $i (0 .. $#{$matrix->[0]} - $max_square){
            # See if there's a 1 here
            if($matrix->[$j][$i]){
                $square_size = 1;
                $growing = 1;

                while($growing){
                    # Check the next column for 1's; a coordinate
                    # outside the matrix evaluates as undef which
                    # effectively counts as 0
                    for $local_j ($j .. $j + $square_size){
                        unless($matrix->[$local_j][$i + $square_size]){
                            $growing = 0;
                            last;
                        }
                    }

                    # Check the next row for 1's- but stop one short
                    # since that element was checked already, above
                    if($growing){
                        for $local_i ($i .. $i + $square_size - 1){
                            unless($matrix->[$j + $square_size][$local_i]){
                                $growing = 0;
                                last;
                            }
                        }
                    }

                    # Enlarge the square
                    $square_size++
                        if($growing);
                }

                # If this square was larger than the previous, make
                # note of the size
                $max_square = $square_size
                    if($square_size > $max_square);
            }
        }
    }
    
    # The size calculated is just the side of the
    # largest square, so... square it
    return($max_square ** 2);

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



