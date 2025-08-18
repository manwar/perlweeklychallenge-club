#!/bin/env raku

unit sub MAIN(Str:D $moves);

use MONKEY-SEE-NO-EVAL;

my @board = ('_' xx 3).Array xx 3;

my @moves = EVAL $moves;
@board[@moves[$_;0];@moves[$_;1]] = <A B>[$_ % 2] for ^+@moves;

my $any-row-col-diagonal = (
    |(@board[$_  ].all for ^3),
    |(@board[*;$_].all for ^3),
    (@board[0;0],@board[1;1],@board[2;2]).all,
    (@board[0;2],@board[1;1],@board[2;0]).all,
).any;

put do given @board {
    when $any-row-col-diagonal eq 'A' { 'A' }
    when $any-row-col-diagonal eq 'B' { 'B' }
    when @board[*;*].any       eq '_' { 'Pending' }
    default                           { 'Draw'}
}
