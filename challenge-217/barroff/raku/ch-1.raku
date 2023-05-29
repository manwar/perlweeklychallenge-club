#!/usr/bin/env raku

use v6.d;

sub sorted-matrix(@matrix where @matrix.elems == @matrix.all --> Int) {
    my @sorted-numbers = sort map(&slip, @matrix);
    return @sorted-numbers[2];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is sorted-matrix(([3, 1, 2], [5, 2, 4], [0, 1, 3])), 1, "works for ([3, 1, 2], [5, 2, 4], [0, 1, 3])";
    is sorted-matrix(([2, 1], [4, 5])), 4, "works for ([2, 1], [4, 5])";
    is sorted-matrix(([1, 0, 3], [0, 0, 0], [1, 2, 1])), 0, "works for ([1, 0, 3], [0, 0, 0], [1, 2, 1])";
}

multi sub MAIN() {
    MAIN('test');
}
