#!/usr/bin/env raku
use Test;

# This solution allows for higher dimensional tic tac toe boards
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

    my @board = ('_' xx $order).Array xx $order;

    my $ltr  = @moves.end %% 2 ?? 'A' !! 'B';
    my $seq := @moves.end %% 2 ?? (0,2...*) !! (1,3...*);

    @moves[$seq].map({ @board[.[0];.[1]] = $ltr });

    # check rows
    return $ltr if @board.first({ .all eq $ltr });

    # check upper left to lower right diagonal
    my @a = (^Inf) Z (^Inf).head(@board);
    return $ltr if @a.map({ @board[.[0];.[1]] }).all eq $ltr;

    # check upper right to lower left diagonal
    @a = (^Inf) Z (@board.end...0);
    return $ltr if @a.map({ @board[.[0];.[1]] }).all eq $ltr;

    # check columns
    return $ltr if ([Z] @board).first({ .all eq $ltr });

    return 'Draw'
}
