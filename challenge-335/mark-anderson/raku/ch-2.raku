#!/usr/bin/env raku
use Test;

# This solution allows for higher dimensional tic-tac-toe boards
# but it doesn't take into account any special rules those may have.

# I didn't check for 'pending' because that's hard to check unless
# you're also given the board size.

is find-winner([0,0],[2,0],[1,1],[2,1],[2,2]),                         'A';
is find-winner([0,0],[1,1],[0,1],[0,2],[1,0],[2,0]),                   'B';
is find-winner([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]), 'Draw';
flunk 'Pending not implemented'; find-winner([0,0],[1,1]);       
is find-winner([1,1],[0,0],[2,2],[0,1],[1,0],[0,2]),                   'B';

sub find-winner(+@moves)
{
    my $order = @moves[*;*].max + 1;
    my @board = (0 xx $order).Array xx $order;

    my $ltr  = @moves.end %% 2 ?? 'A' !! 'B';
    my $seq := @moves.end %% 2 ?? (0,2...*) !! (1,3...*);

    @moves[$seq].map({ @board[.[0];.[1]] = $ltr });

    return $ltr if any
    (
        # check rows
        @board.first.all,

        # check upper left to lower right diagonal
        (^@board).map({@board[$_;$_]}).all,

        # check upper right to lower left diagonal
        (^@board).map({@board[$_;@board.end-$_]}).all,

        # check columns
        ([Z] @board).first.all
    );

    return 'Draw'
}
