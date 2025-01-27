#!/usr/bin/env raku

use v6.d;

sub binary-prefix(@binary --> Seq) {
    my Int $s = 0;
    map({ $s = 2 * $s + $_; $s.is-prime; }, @binary);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is binary-prefix([1, 0 , 1]), [False, True, True], 'works for [1, 0, 1]';
    is binary-prefix([1, 1 , 0]), [False, True, False], 'works for [1, 1, 0]';
    is binary-prefix([1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]),
        [False, True, True, False, False, True, False, False, False, False, False, False, False, False, False, False, False, False, False, True],
        'works for case 3';
}

#| Take user provided number like 1 0 1
multi sub MAIN(*@binary where .all ~~ /^ (0|1) $/) {
    say binary-prefix(@binary);
}
