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
        [4, 3, 2, 1],
        [5, 4, 3, 2],
        [6, 5, 4, 3]
    ],
    [
        [1, 2, 3],
        [3, 2, 1]
    ],

    # Additional test cases
    [
        [1, 2, 3, 4, 5, 6 ],
        [3, 1, 2, 3, 4, 5 ]
    ],
    [
        [ 1, 0 ],
        [ 2, 1 ],
        [ 3, 2 ],
        [ 4, 3 ],
        [ 5, 4 ],
        [ 6, 5 ]
    ],
    [
        [ 1, 2, 3, 4 ],
        [ 4, 1, 2, 3 ],
        [ 3, 4, 1, 2 ],
        [ 2, 2, 4, 1 ]
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \@matrix = (\n%s                 )\n",
        list_of_lists_to_indented_block(
            22,
            @{$matrix}
        )
    );
    printf(
        "Output: %s\n\n",
        is_toeplitz_matrix($matrix) ? "True" : "False"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a matrix is a Toeplitz matrix- that is to say, a matrix in
# which every diagonal downward and to the right contains the same value in
# every position, e.g.:
#
# $matrix = [
#     [ 1, 2, 3, 4 ],
#     [ 4, 1, 2, 3 ],
#     [ 3, 4, 1, 2 ],
#     [ 2, 3, 4, 1 ]
# ];
#
# Takes one argument:
# * A ref to a 2-D array that contains a matrix of numbers (see example above)
# Returns:
# * 0 if the matrix is NOT a Toeplitz matrix
# * 1 if the matrix is a Toeplitz matrix
################################################################################
sub is_toeplitz_matrix{
    use List::Util qw(min);

    my $matrix = shift();

    # Search above (and including) the main
    # diagonal; we skip the last possible
    # value of $m because it's a diagonal of
    # length one
    for my $m (0 .. ($#{$matrix->[0]} - 1)){
        my $value = $matrix->[0][$m];

        for my $l (1 .. min($#$matrix, $#{$matrix->[0]} - $m)){
            return(0)
                unless($matrix->[$l][$m + $l] == $value);
        }
    }

    # Search below the main diagonal; we
    # skip the last possible value of $n
    # because it's a diagonal of length one
    for my $n (0 .. ($#$matrix - 1)){
        my $value = $matrix->[$n][0];

        for my $l (1 .. min($#$matrix - $n, $#{$matrix->[0]})){
            return(0)
                unless($matrix->[$n + $l][$l] == $value);
        }
    }

    return(1);

}



################################################################################
# Build an indented block of text out of a list of lists
# Each individual list will be presented as the code that would produce an
# array ref of values containing the equivalent data, one per line; a single
# string with embedded newlines is returned
# Takes two arguments:
# * The number of spaces to indent (e.g. 4 )
# * The list of lists to stringify (e.g. ( [ 1, 2 ], [ 3, 4 ] ) )
# Returns
# * A single string containing an indented text representation of contents of
#   the list of lists (e.g. "    [ 1, 2 ]\n    [ 3, 4 ]\n" )
################################################################################
sub list_of_lists_to_indented_block{

    my $format_string = (" " x shift()) . "[ %s ]\n";

    return(
        join(
            "",
            map(
                sprintf(
                    $format_string,
                    join(", ", @{$_})
                ),
                @ARG
            )
        )
    );

}



