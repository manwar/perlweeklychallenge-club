#!/usr/bin/env raku

use v6.d;

sub total-xor(@ints --> Int) {
    sum(
        map(
            { reduce(&infix:<+^>, $_) },
            combinations(@ints)
        )
    )
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is total-xor([1, 3]), 6, 'works for "[1, 3]"';
    is total-xor([5, 1, 6]), 28, 'works for "[5, 1, 6]"';
    is total-xor([3, 4, 5, 6, 7, 8]), 480, 'works for "[3, 4, 5, 6, 7, 8]"';
}

#| Take user provided numbers like 3, 4, 5, 6, 7, 8
multi sub MAIN(@ints) {
    say total-xor(@ints);
}
