#!/usr/bin/env raku

use v6.d;

sub arrange-binary(@digits where .all ~~ /^ (0|1) $/, Int $n --> Bool) {
    my %counts;
    %counts{$_} for @digits;
    return %counts{1} + $n ≤ %counts{0} + 1 - $n + 1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is arrange-binary([1, 0, 0, 0, 1], 1), True,
        'works for "[1, 0, 0, 0, 1] and 1"';
    is arrange-binary([1, 0, 0, 0, 1], 2), False,
        'works for "[1, 0, 0, 0, 1] and 2"';
}

#| Take user provided numbers like 2 1 0 0 0 1
multi sub MAIN(Int $n, *@digits where .all ~~ /^ (0|1) $/) {
    say arrange-binary(@digits, $n);
}
