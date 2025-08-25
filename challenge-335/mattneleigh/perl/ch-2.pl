#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @games = (
    [ [0, 0], [2, 0], [1, 1], [2, 1], [2, 2] ],
    [ [0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0] ],
    [ [0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1], [0, 2], [2, 2] ],
    [ [0, 0], [1, 1] ],
    [ [1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2] ]
);

print("\n");
foreach my $game (@games){
    my @output = game_analyzer(@{$game});
    my $winner;

    if($output[0] eq "D"){
        $winner = "A STRANGE GAME.  THE ONLY WINNING MOVE IS NOT TO PLAY.";
    } elsif($output[0] eq "P"){
        $winner = "Pending";
    } else{
        $winner = $output[0];
    }

    printf(
        "Input: \@moves = (%s)\nOutput: %s\n\nGame Board:\n\n%s\n\n\n",
        join(
            ", ",
            map(
                "[ ". join(", ", @{$_}) . " ]",
                @{$game}
            )
        ),
        $winner,
        join(
            "\n",
            map(
                "[ " . join(" ", @{$_}) . " ]",
                @{$output[1]}
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Analyze the outcome of a series of moves in a game of Tic Tac Toe, declaring
# the winner, if any, or whether the game was a draw or is not yet complete
# Takes one argument:
# * A list of moves in the game, starting with X's first move, then O's first
#   move, etc. (e.g. ([0, 0], [2, 0], [1, 1], [2, 1], [2, 2]) )
# Returns:
# * A ref to an array containing two fields:
#   0: A letter that indicates the outcome of the analysis:
#      - "D" if the game is a draw
#      - "O" if O has won the game
#      - "P" if the outcome of the game is still pending
#      - "X" if X has won the game
#   1: A ref to a two dimensional array of characters representing the game
#      board as described by the supplied list of moves, where underscores
#      represent unused squares
#   (e.g.
#       [
#           "X",
#           [
#               [ "X", "_", "_" ],
#               [ "_", "X", "_" ],
#               [ "O", "O", "X" ]
#           ]
#       ]
#   )
################################################################################
sub game_analyzer{

    my @board = (
        [ "_", "_", "_" ],
        [ "_", "_", "_" ],
        [ "_", "_", "_" ]
    );
    my $pending = 0;

    # Apply the supplied moves to the game board
    # for illustrative purposes- we borrow the
    # $pending variable for a moment to determine
    # player identity
    foreach my $move (@ARG){
        $board[$move->[0]][$move->[1]] = $pending ? "O" : "X";
        $pending ^= 1;
    }

    $pending = 0;

    for my $n (0 .. 2){
        # Check for horizontal wins in row $n
        if($board[$n][0] ne "_"){
            if(($board[$n][1] eq "_") || ($board[$n][2] eq "_")){
                $pending = 1;
            } else{
                return($board[$n][0], \@board)
                    if(
                        ($board[$n][0] eq $board[$n][1])
                        &&
                        ($board[$n][0] eq $board[$n][2])
                    );
            }
        } else{
            $pending = 1;
        }

        # Check for vertical wins in column $n
        if($board[0][$n] ne "_"){
            if(($board[1][$n] eq "_") || ($board[2][$n] eq "_")){
                $pending = 1;
            } else{
                return($board[0][$n], \@board)
                    if(
                        ($board[0][$n] eq $board[1][$n])
                        &&
                        ($board[0][$n] eq $board[2][$n])
                    );
            }
        } else{
            $pending = 1;
        }
    }

    # Check for diagonal wins- we will have already
    # seen empty squares so we don't need to set the
    # pending flag
    if($board[0][0] ne "_"){
        return($board[0][0], \@board)
            if(
                ($board[0][0] eq $board[1][1])
                &&
                ($board[0][0] eq $board[2][2])
            );
    }
    if($board[2][0] ne "_"){
        return($board[2][0], \@board)
            if(
                ($board[2][0] eq $board[1][1])
                &&
                ($board[2][0] eq $board[0][2])
            );
    }

    return(
        $pending ?
            "P"
            :
            "D",
        \@board
    );

}



