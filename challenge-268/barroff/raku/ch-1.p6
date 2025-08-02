#!/usr/bin/env raku

use v6.d;

sub magic-number(@x, @y --> Int:D) {
    abs(min(@x) - min(@y))
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is magic-number([3, 7, 5], [9, 5, 7]), 2, 'works for [3, 7, 5] and [9, 5, 7]';
    is magic-number([1, 2, 1], [5, 4, 4]), 3, 'works for [1, 2, 1] and [5, 4, 4]';
    is magic-number([2], [5]), 3, 'works for [2] and [5]';
}
