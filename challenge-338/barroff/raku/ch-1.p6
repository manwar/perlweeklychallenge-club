#!/usr/bin/env raku

use v6.d;

sub highest-row(@matrix --> Int) {
    max(map({ sum($_) }, @matrix))
}

#| Run test cases
sub MAIN() {
    use Test;
    plan 5;

    is highest-row([[4,  4, 4, 4],
                  [10, 0, 0, 0],
                  [2,  2, 2, 9]]), 16, 'works for matrix one';
    is highest-row([[1, 5], [7, 3], [3, 5]]), 10, 'works for matrix two';
    is highest-row([[1, 2, 3], [3, 2, 1]]), 6, 'works for matrix three';
    is highest-row([[2, 8, 7], [7, 1, 3], [1, 9, 5]]), 17, 'works for matrix four';
    is highest-row([[10, 20,  30], [5,  5,   5], [0,  100, 0], [25, 25,  25]]),
        100, 'works for matrix five';
}
