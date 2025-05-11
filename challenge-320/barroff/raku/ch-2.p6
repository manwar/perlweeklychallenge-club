#!/usr/bin/env raku

use v6.d;

sub sum-difference(@ints --> Int) {
    my Int $es = sum(@ints);
    my Int $ds = sum(@ints.join.comb);
    return abs($es - $ds);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is sum-difference([1, 23, 4, 5]), 18, 'works for "[1, 23, 4, 5]"';
    is sum-difference([1, 2, 3, 4, 5]), 0, 'works for "[1, 2, 3, 4, 5]"';
    is sum-difference([1, 2, 34]), 27, 'works for "[1, 2, 34]"';
}

#| Take user provided numbers like 3, 30, 34, 5, 9
multi sub MAIN(*@ints) {
    say sum-difference(@ints);
}
