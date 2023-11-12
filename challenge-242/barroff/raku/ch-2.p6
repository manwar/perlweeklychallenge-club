#!/usr/bin/env raku

use v6.d;

sub flip-matrix(@matrix) {
    map({ map({ $_ == 0 ?? 1 !! 0 }, reverse($_))}, @matrix);
}

#| Run test cases
sub MAIN() {
    use Test;
    plan 2;

    is flip-matrix(([1, 1, 0], [1, 0, 1], [0, 0, 0])),
        ([1, 0, 0], [0, 1, 0], [1, 1, 1]),
        'works for ([1, 1, 0], [1, 0, 1], [0, 0, 0])';
    is flip-matrix(([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])),
        ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]),
        'works for ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])';
}
