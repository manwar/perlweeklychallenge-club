#!/usr/bin/env raku

use v6.d;

sub check-order(@ints --> Seq) {
    my @sorted-ints = sort @ints;
    return grep({ @ints[$_] ≠ @sorted-ints[$_] }, 0..@ints.elems - 1);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is check-order([5, 2, 4, 3, 1]), [0, 2, 3, 4], 'works for [5, 2, 4, 3, 1]';
    is check-order([1, 2, 1, 1, 3]), [1, 3], 'works for [1, 2, 1, 1, 3]';
    is check-order([3, 1, 3, 2, 3]), [0, 1, 3], 'works for [3, 1, 3, 2, 3]';
}

#| Take user provided number like 1 0 1
multi sub MAIN(*@ints) {
    say check-order(@ints);
}
