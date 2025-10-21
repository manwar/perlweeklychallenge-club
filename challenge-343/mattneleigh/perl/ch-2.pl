#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @grids = (
    [
        [ 0, 1, 1 ],
        [ 0, 0, 1 ],
        [ 0, 0, 0 ]
    ],
    [
        [ 0, 1, 0, 0 ],
        [ 0, 0, 0, 0 ],
        [ 1, 1, 0, 0 ],
        [ 1, 1, 1, 0 ]
    ],
    [
        [ 0, 1, 0, 1 ],
        [ 0, 0, 1, 1 ],
        [ 1, 0, 0, 0 ],
        [ 0, 0, 1, 0 ]
    ],
    [
        [ 0, 1, 1 ],
        [ 0, 0, 0 ],
        [ 0, 1, 0 ]
    ],
    [
        [ 0, 0, 0, 0, 0 ],
        [ 1, 0, 0, 0, 0 ],
        [ 1, 1, 0, 1, 1 ],
        [ 1, 1, 0, 0, 0 ],
        [ 1, 1, 0, 1, 0 ]
    ]
);

print("\n");
foreach my $grid (@grids){
    printf(
        "Input: \@grid = (\n%s\n               )\nOutput: Team %d\n\n",
        join(
            "\n",
            map(
                "                    " . $_,
                matrix_to_strings($grid)
            )
        ),
        determine_championship_team($grid)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a n x n grid describing the outcome of a series of games between n
# teams, determine which team is the champion
# Takes one argument:
# * A ref to a n x n array of ones and zeros, representing the outcome of a
#   series of matches between n teams in which 1 represents an instance in
#   which the team in the row coordinate was victorious against the team in the
#   column coordinate (e.g.
#       [
#           [ 0, 1, 0, 0 ],
#           [ 0, 0, 0, 0 ],
#           [ 1, 1, 0, 0 ],
#           [ 1, 1, 1, 0 ]
#       ]
#   )
# Returns:
# * The index of the team that was the most successful in the series of games
#   described in the input grid (e.g. 3)
################################################################################
sub determine_championship_team{
    my $grid = shift();

    my $team;
    my $opponent;

    # Set up a table of win counts and team IDs
    my @teams = map([ 0, $_ ], 0 .. $#$grid);

    # Loop over every pairing of teams on the grid
    foreach $team (0 .. $#$grid){
        foreach $opponent (0 .. $#$grid){
            # Skip positions in which a team would be
            # paired with itself
            next
                if($team == $opponent);

            # Increment the team's win count if it beat
            # the opponent
            $teams[$team][0]++
                if($grid->[$team][$opponent]);
        }
    }

    # Sort the win totals table in descending
    # order by number of wins
    @teams = sort({ $b->[0] <=> $a->[0] } @teams);

    if($teams[0][0] == $teams[1][0]){
        # The top two teams have the same number of
        # wins
        if($grid->[$teams[0][1]][$teams[1][1]]){
            # The first team beat the second team
            return($teams[0][1]);
        } else{
            # The second team beat the first team
            return($teams[1][1]);
        }
    } else{
        # The top team is unambiguously the
        # champion
        return($teams[0][1]);
    }

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



