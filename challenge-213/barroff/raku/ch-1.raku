#!/usr/bin/env raku

use v6.d;

sub fun-sort(Int @numbers --> List) {
    my Int @even = grep({ $_ % 2 == 0 }, @numbers).sort;
    my Int @odd = grep({ $_ % 2 ≠ 0 }, @numbers).sort;
    return (|@even, |@odd);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is fun-sort(Array[Int].new(1,2,3,4,5,6)), (2,4,6,1,3,5), 'Works for (1,2,3,4,5,6)';
    is fun-sort(Array[Int].new(1,2)), (2,1), 'Works for (1,2)';
    is fun-sort(Array[Int].new(1)), (1), 'Works for (1)';
}

