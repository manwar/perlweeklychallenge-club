#!/usr/bin/env raku

use v6.d;

sub sum-of-values(@ints, Int:D $k --> Int:D) {
    return sum(
        @ints[
            grep(
                { sum($_.base(2).comb) == $k }, 0..@ints.elems - 1
            )
        ]
    )
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is sum-of-values((2, 5, 9, 11, 3), 1), 17, 'works for k = 1';
    is sum-of-values((2, 5, 9, 11, 3), 2), 11, 'works for k = 2';
    is sum-of-values((2, 5, 9, 11, 3), 0), 2, 'works for k = 0';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(Int:D $k, *@ints) {
    say sum-of-values(@ints, $k);
}
