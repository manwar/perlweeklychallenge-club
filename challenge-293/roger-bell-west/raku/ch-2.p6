#! /usr/bin/raku

use Test;

plan 6;

is(boomerang([[1, 1], [2, 3], [3, 2]]), True, 'example 1');
is(boomerang([[1, 1], [2, 2], [3, 3]]), False, 'example 2');
is(boomerang([[1, 1], [1, 2], [2, 3]]), True, 'example 3');
is(boomerang([[1, 1], [1, 2], [1, 3]]), False, 'example 4');
is(boomerang([[1, 1], [2, 1], [3, 1]]), False, 'example 5');
is(boomerang([[0, 0], [2, 3], [4, 5]]), True, 'example 6');

sub boomerang(@a) {
    my @delta;
    # coincident points
    for (0, 1) -> $ij {
        for ($ij + 1 .. 2) -> $ik {
            if (@a[$ij][0] == @a[$ik][0] && @a[$ij][1] == @a[$ik][1]) {
                return False;
            }
        }
        @delta.push([@a[$ij + 1][0] - @a[0][0], @a[$ij + 1][1] - @a[0][1]]);
    }
    # all on the same vertical line
    if (@delta[0][0] == 0 && @delta[1][0] == 0) {
        return False;
    }
    # just one vertical line
    if (@delta[0][0] == 0 || @delta[1][0] == 0) {
        return True;
    }
    my $m = @delta[0][1] / @delta[0][0];
    my $c = @a[0][1] - @a[0][0] * $m;
    @a[2][1] != @a[2][0] * $m + $c;
}
