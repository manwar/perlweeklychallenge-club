#!/usr/bin/env raku

use v6.d;

sub boomerang(@points where @points.elems == 3 --> Bool) {
    return False if so @points»[0].all == @points[0][0]
        || so @points»[1].all == @points[0][1];
    my $diff = @points[0] «-» @points[1];
    my $solution = (@points[2] «-» @points[0])[0] «/» $diff;
    return $solution[0] ≠ $solution[1];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 6;

    is boomerang([[1, 1], [2, 3], [3,2]]), True,
        'Works for ([[1, 1], [2, 3], [3,2]])';
    is boomerang([[1, 1], [2, 2], [3, 3]]), False,
        'Works for ([[1, 1], [2, 2], [3, 3]])';
    is boomerang([[1, 1], [1, 2], [2, 3]]), True,
        'Works for ([[1, 1], [1, 2], [2, 3]])';
    is boomerang([[1, 1], [1, 2], [1, 3]]), False,
        'Works for ([[1, 1], [1, 2], [1, 3]])';
    is boomerang([[1, 1], [2, 1], [3, 1]]), False,
        'Works for ([[1, 1], [2, 1], [3, 1]])';
    is boomerang([[0, 0], [2, 3], [4, 5]]), True,
        'Works for ([[0, 0], [2, 3], [4, 5]])';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@points where @points.elems == 6) {
    say boomerang(@points);
}
