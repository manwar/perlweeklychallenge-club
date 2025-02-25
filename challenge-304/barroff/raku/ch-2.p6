#!/usr/bin/env raku

use v6.d;

sub maximum-average(Int $n, @digits where .elems ≥ $n) {
    max(map({ sum(@digits[$_ .. $_ + $n - 1]) }, 0..@digits.elems - $n)) ÷ $n;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is maximum-average(4, [1, 12, -5, -6, 50, 3]), 12.75,
        'works for "[1, 12, -5, -6, 50, 3] and 4"';
    is maximum-average(1, [5]), 5, 'works for "[5] and 1"';
}

#| Take user provided numbers like 2 1 0 0 0 1
multi sub MAIN(Int $n, *@digits) {
    say maximum-average($n, @digits);
}
