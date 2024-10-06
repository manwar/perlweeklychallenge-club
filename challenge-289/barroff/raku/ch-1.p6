#!/usr/bin/env raku

use v6.d;

sub third-maximum(@ints --> Int) {
    my @unique-ints = sort(unique(@ints));
    return elems(@unique-ints) > 2 ?? @unique-ints[*-3] !! @unique-ints[*-1];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is third-maximum([5, 6, 4, 1]), 4, 'works for "(5, 6, 4, 1)"';
    is third-maximum([4, 5]), 5, 'works for "(4, 5)"';
    is third-maximum([1, 2, 2, 3]), 1, 'works for "(1, 2, 2, 3)"';
}

#| Take user provided numbers like 2 2 3 4
multi sub MAIN(*@ints) {
    say third-maximum(@ints);
}
