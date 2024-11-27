#!/usr/bin/env raku

sub double-exist(@ints --> Bool) {
    return so True == map(
        { $_[0] == 2 * $_[1] or $_[1] == 2 * $_[0] },
        combinations(@ints, 2)
    ).any;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is double-exist([6, 2, 3, 3]), True, 'Works for (6, 2, 3, 3)';
    is double-exist([3, 1, 4, 13]), False, 'Works for (3, 1, 4, 13)';
    is double-exist([2, 1, 4, 2]), True, 'Works for (2, 1, 4, 2)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints) {
    say double-exist(@ints);
}
