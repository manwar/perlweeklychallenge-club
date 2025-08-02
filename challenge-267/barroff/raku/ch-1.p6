#!/usr/bin/env raku

use v6.d;

sub product-sign(@ints --> Int) {
    return 0 if 0 (elem) @ints;
    return grep({ $_ < 0 }, @ints).elems % 2 == 0 ?? 1 !! -1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is product-sign([-1, -2, -3, -4, 3, 2, 1]), 1,
        'works for (-1, -2, -3, -4, 3, 2, 1)';
    is product-sign([1, 2, 0, -2, -1]), 0, 'works for (1, 2, 0, -2, -1)';
    is product-sign([-1, -1, 1, -1, 2]), -1, 'works for (-1, -1, 1, -1, 2)';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(*@ints) {
    say product-sign(@ints);
}
