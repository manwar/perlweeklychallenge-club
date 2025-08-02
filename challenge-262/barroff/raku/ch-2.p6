#!/usr/bin/env raku

use v6.d;

sub count-equal-divisible(Int:D $k, @ints --> Int:D) {
    grep(
        { @ints[$_[0]] == @ints[$_[1]] and ($_[0] * $_[1]) mod $k == 0 },
        combinations(0..@ints.elems - 1, 2)
    ).elems
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is count-equal-divisible(2, [3, 1, 2, 2, 2, 1, 3]), 4,
        'works for 2 and (3, 1, 2, 2, 2, 1, 3)';
    is count-equal-divisible(1, [1,2,3]), 0, 'works for 1 and (1,2,3)';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(Int:D $k, *@ints) {
    say count-equal-divisible($k, @ints);
}
