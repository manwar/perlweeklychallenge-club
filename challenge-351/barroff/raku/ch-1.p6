#!/usr/bin/env raku

use v6.d;

sub special-average(@ints --> Int) {
    my @unique-values = Bag(@ints).keys;
    return 0 if @unique-values.elems < 3;
    sum((@unique-values.sort)[1..*-2]) div (@unique-values.elems - 2)
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is special-average([8000, 5000, 6000, 2000, 3000, 7000]), 5250,
        'works for [8000, 5000, 6000, 2000, 3000, 7000]';
    is special-average([100_000, 80_000, 110_000, 90_000]), 95000,
        'works for [100_000, 80_000, 110_000, 90_000]';
    is special-average([2500, 2500, 2500, 2500]), 0,
        'works for [2500, 2500, 2500, 2500]';
    is special-average([2000]), 0, 'works for [2000]';
    is special-average([1000, 2000, 3000, 4000, 5000, 6000]), 3500,
        'works for [1000, 2000, 3000, 4000, 5000, 6000]';
}

#| Take user provided integers such as 1000 2000 3000 4000 5000 6000
multi sub MAIN(Int @ints) {
    say special-average(@ints);
}
