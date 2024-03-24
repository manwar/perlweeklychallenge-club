#!/usr/bin/env raku

use v6.d;

sub element-digit-sum(@ints --> Int:D) {
    sum(@ints) - sum(map({ sum($_.Str.comb.map: -> $x { $x.Int}) }, @ints))
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is element-digit-sum([1, 2, 3, 45]), 36, 'works for (1, 2, 3, 45)';
    is element-digit-sum([1, 12, 3]), 9, 'works for (1, 12, 3)';
    is element-digit-sum([1, 2, 3, 4]), 0, 'works for (1, 2, 3, 4)';
    is element-digit-sum([236, 416, 336, 350]), 1296,
        'works for (236, 416, 336, 350)';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(*@ints) {
    say element-digit-sum(@ints);
}
