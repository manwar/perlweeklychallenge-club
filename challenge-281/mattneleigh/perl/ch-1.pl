#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @chess_squares = (
    "d3",
    "g5",
    "e6"
);

print("\n");
foreach my $chess_square (@chess_squares){
    printf(
        "Input: \$coordinates = \"%s\"\nOutput: %s\n\n",
        $chess_square,
        is_chess_square_light($chess_square) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a given square on a chessboard is light or dark, given its
# coordinates in Algebraic Notation- file (a-h) and rank (1-8)
# Takes one argument:
# * The coordinates of the square in algebraic notation (e.g. "d3")
# Returns:
# * 0 if the square is dark; 1 if the square is light
################################################################################
sub is_chess_square_light{
    my ($file, $rank) = split(//, shift());

    return(
        # Convert the file coordinate to a number
        # (1-indexed) then determine whether each
        # coordinate is even, and XOR the results
        ((ord(lc($file)) - 96) % 2) ^ ($rank % 2)
    );

}



