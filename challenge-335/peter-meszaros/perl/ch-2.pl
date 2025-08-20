#!/usr/bin/env perl
#
=head1 Task 2: Find Winner

Submitted by: Mohammad Sajid Anwar

You are given an array of all moves by the two players.

Write a script to find the winner of the TicTacToe game if found based on the
moves provided in the given array.

UPDATE: Order move is in the order - A, B, A, B, A, ...

=head2 Example 1

    Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
    Output: A

    Game Board:
    [ A _ _ ]
    [ B A B ]
    [ _ _ A ]

=head2 Example 2

    Input: @moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0])
    Output: B

    Game Board:
    [ A A B ]
    [ A B _ ]
    [ B _ _ ]

=head2 Example 3

    Input: @moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2])
    Output: Draw

    Game Board:
    [ A A B ]
    [ B B A ]
    [ A B A ]

=head2 Example 4

    Input: @moves = ([0,0],[1,1])
    Output: Pending

    Game Board:
    [ A _ _ ]
    [ _ B _ ]
    [ _ _ _ ]

=head2 Example 5

    Input: @moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2])
    Output: B

    Game Board:
    [ B B B ]
    [ A A _ ]
    [ _ _ A ]

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/all/;

my $cases = [
    [[[0,0],[2,0],[1,1],[2,1],[2,2]],                         "A",       "Example 1"],
    [[[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]],                   "B",       "Example 2"],
    [[[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]], "Draw",    "Example 3"],
    [[[0,0],[1,1]],                                           "Pending", "Example 4"],
    [[[1,1],[0,0],[2,2],[0,1],[1,0],[0,2]],                   "B",       "Example 5"],
];

sub check_winner
{
    my ($board, $player) = @_;
    
    for my $i (0 .. 2) {
        return 1 if all { $_ eq $player } @{$board->[$i]};
        return 1 if all { $_ eq $player } map { $_->[$i] } @$board;
    }

    return 1 if all { $board->[$_][$_] eq $player } (0 .. 2);
    return 1 if all { $board->[$_][2 - $_] eq $player } (0 .. 2);

    return 0;
}

sub find_winner
{
    my $moves = shift;

    my @board = (['_', '_', '_'], ['_', '_', '_'], ['_', '_', '_']);

    my $turn = 0;
    for my $move (@$moves) {
        my ($x, $y) = @$move;
        my $player = $turn ? 'B' : 'A';
        $board[$x][$y] = $player;

        return $player if check_winner(\@board, $player);

        $turn = 1 - $turn;
    }
    return @$moves < 9 ? 'Pending' : 'Draw';
}

for (@$cases) {
    is(find_winner($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
