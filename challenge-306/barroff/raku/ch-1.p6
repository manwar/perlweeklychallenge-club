#!/usr/bin/env raku

use v6.d;

sub sum-n-slices(@ints, Int $n --> Int) {
    sum(
        map(
            {
                @ints[$_ - 1] ×
                min($n, $_, @ints.elems + 1 - $_, @ints.elems + 1 - $n)
            },
            1..@ints.elems
        )
    )
}

sub odd-sum(@ints --> Int) {
    sum(
        map(
            { $_ %% 2 ?? 0 !! sum-n-slices(@ints, $_) },
            1..@ints.elems
        )
    )
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is odd-sum([2, 5, 3, 6, 4]), 77, 'works for [2, 5, 3, 6, 4]';
    is odd-sum([1, 3]), 4, 'works for [1, 3]';
}

#| Take user provided number like 1 0 1
multi sub MAIN(*@ints) {
    say odd-sum(@ints);
}
