#!/usr/bin/env raku

use v6.d;

sub build-array(@ints, --> Positional:D) {
    List(
        map(
            { @ints[$_] ≥ @ints.elems ?? Nil !! @ints[@ints[$_]] },
            0..^@ints.elems
        )
    )
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is build-array([0, 2, 1, 5, 3, 4]), [0, 1, 2, 4, 5, 3],
        'works for (0, 2, 1, 5, 3, 4)';
    is build-array([5, 0, 1, 2, 3, 4]), [4, 5, 0, 1, 2, 3],
        'works for (5, 0, 1, 2, 3, 4)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints where @ints.elems ≥ 1) {
    say build-array(@ints);
}
