#!/usr/bin/env raku

use v6.d;

sub smaller-than-n(Int:D $n, @ints --> Int:D) {
    grep({ $_ < $n }, @ints).elems;
}

sub smaller-than-current(@ints--> Seq) {
    map({ smaller-than-n($_, @ints) }, @ints);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is smaller-than-current(( 5, 2, 1, 6 )), (2, 1, 0, 3),
        'works for (5, 2, 1, 6)';
    is smaller-than-current(( 1, 2, 0, 3 )), (1, 2, 0, 3),
        'works for (1, 2, 0, 3)';
    is smaller-than-current(( 0, 1 )), (0, 1), 'works for (0, 1)';
    is smaller-than-current(( 9, 4, 9, 2 )), (2, 1, 2, 0),
        'works for (9, 4, 9, 2)';
}

#| Take user provided number like 10
multi sub MAIN(Int:D @ints) {
    say smaller-than-current(@ints);
}
