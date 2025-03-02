#!/usr/bin/env raku

use v6.d;

sub arrays-intersection(@list --> Seq:D) {
    ([∩] @list).keys.sort;
}

#| Run test cases
sub MAIN('test') {
    use Test;
    plan 3;

    is arrays-intersection(( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )), (1, 4),
        'works for case one';
    is arrays-intersection(( [1, 0, 2, 3], [2, 4, 5] )), (2),
        'works for case two';
    is arrays-intersection(( [1, 2, 3], [4, 5], [6] )), "",
        'works for case three';
}
