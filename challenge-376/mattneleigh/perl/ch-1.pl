#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @board = (
    [ qw( B W B W B W B W ) ],
    [ qw( W B W B W B W B ) ],
    [ qw( B W B W B W B W ) ],
    [ qw( W B W B W B W B ) ],
    [ qw( B W B W B W B W ) ],
    [ qw( W B W B W B W B ) ],
    [ qw( B W B W B W B W ) ],
    [ qw( W B W B W B W B ) ]
);

my @coordinate_pairs = (
    [ "a7", "f4" ],
    [ "c1", "e8" ],
    [ "b5", "h2" ],
    [ "f3", "h1" ],
    [ "a1", "g8" ]
);

print("\n");
foreach my $coordinate_pair (@coordinate_pairs){
    printf(
        "Input: \$c1 = \"%s\", \$c2 = \"%s\"\nOutput: %s\n\n",
        $coordinate_pair->[0],
        $coordinate_pair->[1],
        coords_same_color(\@board, @{$coordinate_pair}) ?
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
# Determine whether two coordinates represent squares on the chessboard that
# are the same color
# Takes three arguments:
# * A ref to 2D array representing the chessboard, in which the rows of the
#   array represent the numerical portion of the coordinate, and the columns
#   represent the letter portion of the coordinate (e.g.
#       [
#           [ "B", "W", "B", "W", "B", "W", "B", "W" ],
#           [ "W", "B", "W", "B", "W", "B", "W", "B" ],
#           [ "B", "W", "B", "W", "B", "W", "B", "W" ],
#           [ "W", "B", "W", "B", "W", "B", "W", "B" ],
#           [ "B", "W", "B", "W", "B", "W", "B", "W" ],
#           [ "W", "B", "W", "B", "W", "B", "W", "B" ],
#           [ "B", "W", "B", "W", "B", "W", "B", "W" ],
#           [ "W", "B", "W", "B", "W", "B", "W", "B" ]
#       ]
#   ).  Note that the order of the rows is reversed from that which one might
#   expect, such that row 1 of algebraic notation corresponds to row 0 of the
#   array
# * The first coordinate (e.g. "c1" )
# * The second coordinate (e.g. "e8" )
# Returns:
# * 0 if the two indicated squares do not match, colorwise (as it would be in
#   the case of the example above)
# * 1 if the two indicated squares match, colorwise
################################################################################
sub coords_same_color{
    my $board = shift();

    # Split each coordinate into individual
    # characters
    my @coords = map(
        [ split("", $_) ],
        @ARG
    );

    return(
        # Compare each coordinate's color on the
        # chess board and return the appropriate
        # value
        $board->[$coords[0][1] - 1][ord($coords[0][0]) - 97]
        eq
        $board->[$coords[1][1] - 1][ord($coords[1][0]) - 97] ?
            1
            :
            0
    );

}



