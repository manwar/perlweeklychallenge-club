#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_searches = (
    # Given cases
    [
        [
            [ "A", "B", "D", "E" ],
            [ "C", "B", "C", "A" ],
            [ "B", "A", "A", "D" ],
            [ "D", "B", "B", "C" ]
        ],
        "BDCA"
    ],
    [
        [
            [ "A", "A", "B", "B" ],
            [ "C", "C", "B", "A" ],
            [ "C", "A", "A", "A" ],
            [ "B", "B", "B", "B" ]
        ],
        "ABAC"
    ],
    [
        [
            [ "B", "A", "B", "A" ],
            [ "C", "C", "C", "C" ],
            [ "A", "B", "A", "B" ],
            [ "B", "B", "A", "A" ]
        ],
        "CCCAA"
    ],

    # Additional test cases
    [
        [
            [ "A", "B", "D", "E" ],
            [ "C", "B", "C", "A" ],
            [ "B", "A", "Q", "D" ],
            [ "D", "B", "B", "C" ]
        ],
        "Q"
    ],
);

print("\n");
foreach my $word_search (@word_searches){
    printf(
        "Input: \@chars = (\n%s\n                )\n      \$str = \"%s\"\n" .
        "Output: %s\n\n",
        join(
            "\n",
            map(
                {
                    # Add single quotes around each letter
                    $_ =~ s/([A-Z])/'$1'/g;
                    "                    " . $_;
                }
                matrix_to_strings($word_search->[0])
            )
        ),
        $word_search->[1],
        string_present_in_matrix($word_search) ?
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
# Given a matrix of characters and a string to search for therein, determine
# whether the string is present; the string may occur along any path using only
# orthogonal directions traversing unique cells
# Takes one argument:
# * A ref to an array that contains a matrix of characters and a string to
#   search for within the matrix (e.g.
#       [
#           [
#               [ "B", "A", "B", "A" ],
#               [ "C", "C", "C", "C" ],
#               [ "A", "B", "A", "B" ],
#               [ "B", "B", "A", "A" ]
#           ],
#           "CCCAA"
#       ]
#  )
# Returns:
# * 0 if the string was not found within the matrix
# * 1 if the string was found within the matrix (as it would be in the example
#   above)
################################################################################
sub string_present_in_matrix{
    my $input = shift();

    my @letters = split(//, $input->[1]);
    my %cell_traversed = ();

    # Loop over every coordinate in the matrix
    for my $j (0 .. $#{$input->[0]}){
        for my $i (0 .. $#{$input->[0][0]}){
            return(1)
                if(
                    # Is the letter at this cell the first one
                    # we're looking for?
                    ($input->[0][$j][$i] eq $letters[0])
                    &&
                    # Was this the only letter, or did the
                    # searching function indicate success?
                    (
                        ($#letters == 0)
                        ||
                        _search_adjacent_cells(
                            $input->[0],
                            \@letters,
                            \%cell_traversed,
                            $i, $j, 1
                        )
                    )
                );
        }
    }

    # If we got here, we didn't find the string
    # within the matrix
    return(0);

}



################################################################################
# Recursively examine adjacent cells in a matrix of characters, starting with
# the specified one, looking for the specified (and subsequent) characters in
# adjacent (and subsequently adjacent) cells, to determine if the string is
# present in the matrix in a contiguous orthogonal sequence of unique cells
# Takes six arguments:
# * A ref to the matrix of characters to examine (e.g.
#       [
#           [ "B", "A", "B", "A" ],
#           [ "C", "C", "C", "C" ],
#           [ "A", "B", "A", "B" ],
#           [ "B", "B", "A", "A" ]
#       ]
#  )
# * A ref to a list of letters from the string to search for (e.g.
#   [ "C", "C", "C", "A", "A" ] )
# * A ref to an empty hash that will be used to keep track of cells traversed
#   in the search for characters within the matrix
# * The row coordinate to examine at the start of the search
# * The column coordinate to examine at the start of the search
# * The index of the letter to look for in the specified cell, with respect to
#   the list referenced in the second argument
# Returns:
# * 0 if the specified characters were not found adjacent to this- and
#   subsequently adjacent- locations within the matrix
# * 1 if the specified characters were found adjacent to this- and subsequently
#   adjacent- locations within the matrix
# NOTE: This function should only be called by string_present_in_matrix()
################################################################################
sub _search_adjacent_cells{
    my ($matrix, $letters, $cell_traversed, $i, $j, $letter) = @ARG;

    my $coord_string = $i . "-" . $j;
    my $next_i;
    my $next_j;

    # Mark the current coordinate as cell_traversed
    $cell_traversed->{$coord_string} = 1;

    # Check each of the four adjacent cells in
    # orthoogonal directions
    #                      Up       Down    Left     Right
    foreach my $direction ([0, -1], [0, 1], [-1, 0], [1, 0]){
        $next_i = $i + $direction->[0];
        $next_j = $j + $direction->[1];

        # See if we should process this next cell...
        next
            unless(
                # Will the next cell be inside the matrix?
                (($next_i >= 0) && ($next_i <= $#{$matrix->[0]}))
                &&
                (($next_j >= 0) && ($next_j <= $#$matrix))
                &&
                # Does the next cell contain the next letter of
                # interest?
                ($matrix->[$next_j][$next_i] eq $letters->[$letter])
                &&
                # Have we NOT visited the next cell already?
                !$cell_traversed->{$next_i . "-" . $next_j}
            );

        # See if we should signal success...
        return(1)
            if(
                # Was this the last match required?
                ($letter == $#$letters)
                ||
                # Was a subsequent match found?
                _search_adjacent_cells(
                    $matrix,
                    $letters,
                    $cell_traversed,
                    $next_i, $next_j, $letter + 1
                )
            );
    }

    # Got here- must not have found a match in this or
    # a deeper call; delete the current coordinate
    # from the traversal table and return 0
    delete($cell_traversed->{$coord_string});

    return(0);

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



