#!/usr/bin/env raku

use v6.d;

sub min-gap(@ints --> Int) {
    return @ints[0] if @ints.elems < 2;
    my @diffs = @ints[1..*-1] Z- @ints[0..*-2];
    return @ints[
        grep(
            { @diffs[$_] == min(@diffs) },
            0..@ints.elems - 2
        )[0] + 1
    ];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is min-gap([2, 8, 10, 11, 15]), 11, 'works for [2, 8, 10, 11, 15]';
    is min-gap([1, 5, 6, 7, 14]), 6, 'works for [1, 5, 6, 7, 14]';
    is min-gap([8, 20, 25, 28]), 28, 'works for [8, 20, 25, 28]';
}

#| Take user provided number like 2 8 10 11 15
multi sub MAIN(*@ints) {
    say min-gap(@ints);
}
