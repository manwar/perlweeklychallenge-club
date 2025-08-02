#!/usr/bin/env raku

use v6.d;

sub max-positive-negative(@ints --> Int:D) {
    max(grep({ $_ < 0 }, @ints).elems, grep({ $_ > 0 }, @ints).elems)
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is max-positive-negative([-3, 1, 2, -1, 3, -2, 4]), 4,
        'works for (-3, 1, 2, -1, 3, -2, 4)';
    is max-positive-negative([-1, -2, -3, 1]), 3, 'works for (-1, -2, -3, 1)';
    is max-positive-negative([1, 2]), 2, 'works for (1, 2)';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(*@ints) {
    say max-positive-negative(@ints);
}
