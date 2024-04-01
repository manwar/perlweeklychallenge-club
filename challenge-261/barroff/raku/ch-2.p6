#!/usr/bin/env raku

use v6.d;

sub multiply-by-two(Int:D $start, @ints --> Int:D) {
    $start (elem) @ints ?? multiply-by-two(2 * $start, @ints) !! $start;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is multiply-by-two(3, [5,3,6,1,12]), 24, 'works for 3 and (5, 3, 6, 1, 12)';
    is multiply-by-two(1, [1,2,4,3]), 8, 'works for 1 and (1, 2, 4, 3)';
    is multiply-by-two(2, [5,6,7]), 2, 'works for 2 and (5,6,7)';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(Int:D $start, *@ints) {
    my Int:D @integer_ints = @ints.map: *.Int;
    say multiply-by-two($start.Int, @integer_ints);
}
