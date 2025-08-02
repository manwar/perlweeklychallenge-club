#!/usr/bin/env raku

use v6.d;

sub target-index(Int:D $k, @ints --> Positional) {
    indices(@ints.sort.join, $k)
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is target-index(2, [1, 5, 3, 2, 4, 2]), (1, 2),
        'works for 2 and (1, 5, 3, 2, 4, 2)';
    is target-index(6, [1, 2, 4, 3, 5]), (), 'works for 6 and (1, 2, 4, 3, 5)';
    is target-index(4, [5, 3, 2, 4, 2, 1]), (4),
        'works for 4 and (5, 3, 2, 4, 2, 1)';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(Int:D $k, *@ints) {
    say target-index($k, @ints);
}
