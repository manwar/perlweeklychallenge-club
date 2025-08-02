#!/usr/bin/env raku

use v6.d;

sub concatenation-value(@ints --> Int:D) {
    if @ints.elems % 2 == 0  {
        return sum(map({ @ints[$_] ~ @ints[* - $_ - 1]}, 0..@ints.elems / 2 - 1));
    } else {
        my Int $mid = floor(@ints.elems ÷ 2);
        return sum(map({ @ints[$_] ~ @ints[* - $_ - 1] }, 0..$mid - 1)) +
            @ints[$mid];
    }
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is concatenation-value((6, 12, 25, 1)), 1286, 'works for (6, 12, 25, 1)';
    is concatenation-value((10, 7, 31, 5, 2, 2)), 489, 'works for (10, 7, 31, 5, 2, 2)';
    is concatenation-value((1, 2, 10)), 112, 'works for (1, 2, 10)';
}

#| Take user provided list like 1 2 10
multi sub MAIN(*@s) {
    say concatenation-value(@s);
}
