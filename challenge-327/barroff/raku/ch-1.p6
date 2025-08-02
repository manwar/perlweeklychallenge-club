#!/usr/bin/env raku

use v6.d;

sub missing-integers(@ints --> Positional) {
    Set(1..@ints.elems) (-) Set(@ints).keys.List
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is missing-integers([1, 2, 1, 3, 2, 5]).sort, (4, 6), 'works for "[1, 2, 1, 3, 2, 5]"';
    is missing-integers([1, 1, 1]).sort, (2, 3), 'works for "[1, 1, 1]"';
    is missing-integers([2, 2, 1]), (3), 'works for "[2, 2, 1]"';
}

#| Take user provided numbers like 3, 30, 34, 5, 9
multi sub MAIN(*@ints) {
    say missing-integers(@ints);
}
