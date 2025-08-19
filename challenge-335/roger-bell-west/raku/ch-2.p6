#! /usr/bin/raku

use Test;

plan 5;

is(findwinner([[0, 0], [2, 0], [1, 1], [2, 1], [2, 2]]), 'A', 'example 1');
is(findwinner([[0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]]), 'B', 'example 2');
is(findwinner([[0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1], [0, 2], [2, 2]]), 'Draw', 'example 3');
is(findwinner([[0, 0], [1, 1]]), 'Pending', 'example 4');
is(findwinner([[1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]]), 'B', 'example 5');

sub findwinner(@a) {
    my @board = [
        [ 0, 0, 0 ],
        [ 0, 0, 0 ],
        [ 0, 0, 0 ],
    ];
    my $player = 1;
    for @a -> @play {
        @board[@play[0]][@play[1]] = $player;
        $player = 3 - $player;
    }
    for [
        [0, 0, 1, 0],
        [0, 1, 1, 0],
        [0, 2, 1, 0],
        [0, 0, 0, 1],
        [1, 0, 0, 1],
        [2, 0, 0, 1],
        [0, 0, 1, 1],
        [0, 2, 1, -1],
    ] -> @pattern {
        my %cellvals = SetHash.new;
        for 0 .. 2 -> $i {
            my $x = @pattern[0] + $i * @pattern[2];
            my $y = @pattern[1] + $i * @pattern[3];
            %cellvals{@board[$y][$x]}++;
        }
        if (%cellvals.elems == 1) {
            my $winner = %cellvals.keys[0];
            if ($winner == 1) {
                return "A";
            } elsif ($winner == 2) {
                return "B";
            }
        }
    }
    if (@a.elems == 9) {
        return "Draw";
    } else {
        return "Pending";
    }
}
