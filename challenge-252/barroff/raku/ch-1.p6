#!/usr/bin/env raku

use v6.d;

sub special-numbers(@ints --> Int:D) {
    sum(map({ @ints[$_ - 1] ** 2 }, grep({ @ints.elems % $_ == 0 }, 1..@ints.elems)));
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is special-numbers((1, 2, 3, 4)), 21, 'works for (1, 2, 3, 4)';
    is special-numbers((2, 7, 1, 19, 18, 3)), 63, 'works for (2, 7, 1, 19, 18, 3)';
}

#| Take user provided list like 1 2 10
multi sub MAIN(*@s) {
    say special-numbers(@s);
}
