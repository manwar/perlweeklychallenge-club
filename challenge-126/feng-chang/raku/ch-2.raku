#!/bin/env raku

sub is-mine(Array:D $game, Int:D $row, Int:D $col, UInt:D $max-row, UInt:D $max-col --> Bool:D) {
    return False unless 0 ≤ $row < $max-row;
    return False unless 0 ≤ $col < $max-col;
    $game[$row;$col] eq 'x'
}

sub neibours(Array:D $game, UInt:D $row, UInt:D $col --> Str:D) {
    $game[$row;$col] eq 'x' ?? 'x' !! (
            ( 1, -1), ( 1, 0), ( 1, 1),
            ( 0, -1),          ( 0, 1),
            (-1, -1), (-1, 0), (-1, 1)
        ).map({ is-mine($game, $row + .[0], $col + .[1], $game.elems, $game[0].elems) }).grep(?*).elems.Str
}

sub MAIN(Str:D $f where $f.IO.e = 'input.txt') {
    my Array $game = $f.IO.lines».comb.Array;
    for ^$game.elems -> $row {
        put (^$game[0].elems).map({ neibours($game, $row, .[0]) }).join(' ');
    }
}
