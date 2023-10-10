#!/usr/bin/env raku

use v6.d;

sub greatness(@ints, @permutation --> Int:D) {
    sum(map({ $_[0] < $_[1] ?? 1 !! 0 }, zip(@ints, @permutation)));
}

sub maximise-greatness(@ints --> Int:D) {
    max(map({ greatness(@ints, $_) }, permutations(@ints).race));
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is maximise-greatness([1, 3, 5, 2, 1, 3, 1]), 4,
        'works for (1, 3, 5, 2, 1, 3, 1)';
    is maximise-greatness([1, 2, 3, 4]), 3, 'works for (1, 2, 3, 4)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints where @ints.elems ≥ 1) {
    say maximise-greatness(@ints);
}
