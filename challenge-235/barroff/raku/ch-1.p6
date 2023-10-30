#!/usr/bin/env raku

use v6.d;

sub remove-one(@ints --> Bool:D) {
    return True if @ints.elems ≤ 2;
    my @comparisons = map({ @ints[$_] < @ints[$_ + 1] ?? 0 !! 1 }, 0..@ints.elems - 2);
    return sum(@comparisons) < 2;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is remove-one([0, 2, 9, 4, 6]), True,  'works for (0, 2, 9, 4, 6)';
    is remove-one([5, 1, 3, 2]),    False, 'works for (5, 1, 3, 2)';
    is remove-one([2, 2, 3]),       True,  'works for (2, 2, 3)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints where @ints.elems ≥ 1) {
    say remove-one(@ints);
}

