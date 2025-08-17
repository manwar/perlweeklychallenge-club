#!/usr/bin/env raku

use v6.d;

sub range-sum(Int $x, Int $y, @ints --> Int) {
    sum(@ints[$x..$y]);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is range-sum(0, 2, [-2, 0, 3, -5, 2, -1]), 1,
        'works for "[-2, 0, 3, -5, 2, -1]"';
    is range-sum(1, 3, [1, -2, 3, -4, 5]), -3, 'works for "[1, -2, 3, -4, 5]"';
    is range-sum(3, 4, [1, 0, 2, -1, 3]), 2, 'works for "[1, 0, 2, -1, 3]"';
    is range-sum(0, 3, [-5, 4, -3, 2, -1, 0]), -2,
        'works for "[-5, 4, -3, 2, -1, 0]"';
    is range-sum(0, 2, [-1, 0, 2, -3, -2, 1]), 1,
        'works for "[-1, 0, 2, -3, -2, 1]"';
}

#| Take user provided numbers like 0 2 -2 0 3 -5 2 -1
multi sub MAIN(Int $x, Int $y, *@ints) {
    say range-sum($x, $y, @ints);
}
