#!/usr/bin/env raku

use v6.d;

sub max-distance(@arr1, @arr2 --> Int) {
    max(abs(max(@arr1) - min(@arr2)), abs(max(@arr2) - min(@arr1)))
}

#| Run test cases
sub MAIN() {
    use Test;
    plan 5;

    is max-distance([4, 5, 7], [9, 1, 3, 4]), 6,
        'works for [4, 5, 7] and [9, 1, 3, 4]';
    is max-distance([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]), 6,
        'works for [2, 3, 5, 4] and [3, 2, 5, 5, 8, 7]';
    is max-distance([2, 1, 11, 3], [2, 5, 10, 2]), 9,
        'works for [2, 1, 11, 3] and [2, 5, 10, 2]';
    is max-distance([1, 2, 3], [3, 2, 1]), 2, 'works for [1, 2, 3] and [3, 2, 1]';
    is max-distance([1, 0, 2, 3], [5, 0]), 5, 'works for [1, 0, 2, 3] and [5, 0]';
}
