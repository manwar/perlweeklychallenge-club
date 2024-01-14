#!/usr/bin/env raku

sub smallest-index(@ints --> Int:D) {
    my Int:D @indices = grep({ @ints[$_] % 10 == $_}, 0..@ints.elems - 1);
    return @indices ?? @indices[0] !! -1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is smallest-index([0, 1, 2]), 0, 'Works for (0, 1, 2)';
    is smallest-index([4, 3, 2, 1]), 2, 'Works for (4, 3, 2, 1)';
    is smallest-index([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]), -1,
        'Works for (1, 2, 3, 4, 5, 6, 7, 8, 9, 0)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints) {
    say smallest-index(@ints);
}
