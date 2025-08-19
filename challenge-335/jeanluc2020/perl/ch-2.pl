#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-335/#TASK2
#
# Task 2: Find Winner
# ===================
#
# You are given an array of all moves by the two players.
#
# Write a script to find the winner of the TicTacToe game if found based on the
# moves provided in the given array.
#
# UPDATE: Order move is in the order - A, B, A, B, A, ….
#
## Example 1
##
## Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
## Output: A
##
## Game Board:
## [ A _ _ ]
## [ B A B ]
## [ _ _ A ]
#
# Note: Example 1 has a typo either in the list of moves (second move
# should be [1,0]) or in the output Game Board (B in line 1 column 0
# should move to line 2, column 0). I just use both alternatives below
#
## Example 2
##
## Input: @moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0])
## Output: B
##
## Game Board:
## [ A A B ]
## [ A B _ ]
## [ B _ _ ]
#
#
## Example 3
##
## Input: @moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2])
## Output: Draw
##
## Game Board:
## [ A A B ]
## [ B B A ]
## [ A B A ]
#
#
## Example 4
##
## Input: @moves = ([0,0],[1,1])
## Output: Pending
##
## Game Board:
## [ A _ _ ]
## [ _ B _ ]
## [ _ _ _ ]
#
#
## Example 5
##
## Input: @moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2])
## Output: B
##
## Game Board:
## [ B B B ]
## [ A A _ ]
## [ _ _ A ]
#
############################################################
##
## discussion
##
############################################################
#
# Let's first initialize an empty board. Then we replace the fields
# corresponding to a move with the corresponding character.
# Now we have to check the board - all rows, columns and diagonals.
# If we find a winning position for any of the players, return the
# result. If we don't, then we return "Draw" if all fields in the
# board have been filled, otherwise we return "Pending".

use v5.36;

find_winner([0,0],[2,0],[1,1],[2,1],[2,2]);
find_winner([0,0],[1,0],[1,1],[2,1],[2,2]);
find_winner([0,0],[1,1],[0,1],[0,2],[1,0],[2,0]);
find_winner([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]);
find_winner([0,0],[1,1]);
find_winner([1,1],[0,0],[2,2],[0,1],[1,0],[0,2]);


sub find_winner( @moves ) {
    say "Input: (" . join(", ", map {"[$_->[0],$_->[1]]"} @moves) . ")";
    my $board = [ ["_", "_", "_"], ["_", "_", "_"], ["_", "_", "_"] ];
    my $next = "A";
    foreach my $move (@moves) {
        $board->[$move->[0]]->[$move->[1]] = $next;
        $next = $next eq "A" ? "B" : "A";
    }
    my $winner = "Pending";
    my $is_filled = 1;
    foreach my $x (0..2) {
        foreach my $y (0..2) {
            $is_filled = 0 if $board->[$x]->[$y] eq "_";
        }
    }
    # let's check the rows
    foreach my $x (0..2) {
        if($board->[$x]->[0] eq $board->[$x]->[1] && $board->[$x]->[1] eq $board->[$x]->[2] && $board->[$x]->[0] ne "_") {
            return say "Output: $board->[$x]->[0]";
        }
    }
    # let's check the columns
    foreach my $y (0..2) {
        if($board->[0]->[$y] eq $board->[1]->[$y] && $board->[1]->[$y] eq $board->[2]->[$y] && $board->[0]->[$y] ne "_") {
            return say "Output: $board->[0]->[$y]";
        }
    }
    # let's check the diagonals
    if($board->[0]->[0] eq $board->[1]->[1] && $board->[1]->[1] eq $board->[2]->[2] && $board->[1]->[1] ne "_") {
        return say "Output: $board->[0]->[0]";
    }
    if($board->[2]->[0] eq $board->[1]->[1] && $board->[1]->[1] eq $board->[0]->[2] && $board->[1]->[1] ne "_") {
        return say "Output: $board->[2]->[0]";
    }
    if($is_filled) {
        $winner = "Draw";
    }
    say "Output: $winner";
}
