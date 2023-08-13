#!/usr/bin/env raku

use v6.d;

sub two-out-of-three(@array1, @array2, @array3 --> Set) {
    my Set $set1 = Set(@array1);
    my Set $set2 = Set(@array2);
    my Set $set3 = Set(@array3);
    ($set1 ∩ $set2) ∪ ($set1 ∩ $set3) ∪ ($set2 ∩ $set3);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is-deeply two-out-of-three((1, 1, 2, 4), (2, 4), (4,)), Set(2, 4),
        'works for (2, 4)';
    is-deeply two-out-of-three((4, 1), (2, 4), (1, 2)), Set(1, 2, 4),
        'works for (1, 2, 4)';
}
