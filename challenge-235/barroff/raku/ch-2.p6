#!/usr/bin/env raku

use v6.d;

sub duplicate-zeros(@ints --> Positional) {
    my @result = map({ $_ == 0 ?? Slip.new(0, 0) !! $_ }, @ints);
    return @result[0..@ints.elems - 1];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is duplicate-zeros([1, 0, 2, 3, 0, 4, 5, 0]), (1, 0, 0, 2, 3, 0, 0, 4),
        'works for (1, 0, 2, 3, 0, 4, 5, 0)';
    is duplicate-zeros([1, 2, 3]),                (1, 2, 3),
        'works for (1, 2, 3)';
    is duplicate-zeros([0, 3, 0, 4, 5]),          (0, 0, 3, 0, 0),
        'works for (0, 3, 0, 4, 5)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints where @ints.elems ≥ 1) {
    say duplicate-zeros(@ints);
}
