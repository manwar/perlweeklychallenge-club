#!/usr/bin/env raku

use v6.d;

sub min-max(@ints) {
    return -1 if @ints.elems < 3;
    my @sorted-ints = sort @ints;
    return @sorted-ints[1..*-2];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is min-max([ 3, 2, 1, 4 ]), sort([3, 2]), 'works for (3, 2, 1, 4)';
    is min-max([ 3, 1 ]), -1, 'works for (3, 1)';
    is min-max([ 2, 1, 3 ]), [2], 'works for (2, 1, 3)';
}


#| Take user provided list like 1 24 51 60
multi sub MAIN(*@ints where @ints.elems ≥ 1) {
    say min-max(@ints);
}
