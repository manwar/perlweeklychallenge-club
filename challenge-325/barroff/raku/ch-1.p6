#!/usr/bin/env raku

use v6.d;

sub consecutive-one(@binary --> Int) {
    return 0 unless 1 ∈ @binary;
    max(map({ $_.chars }, @binary.join.split('0')));
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is consecutive-one([0, 1, 1, 0, 1, 1, 1]), 3,
        'Works for ([0, 1, 1, 0, 1, 1, 1])';
    is consecutive-one([0, 0, 0, 0]), 0,
        'Works for ([0, 0, 0, 0])';
    is consecutive-one([1, 0, 1, 0, 1, 1]), 2, 'Works for ([1, 0, 1, 0, 1, 1])';
}

#| Take user provided list like 1 1 0 0 1 1 1 0 1
multi sub MAIN(*@binary) {
    say consecutive-one(@binary);
}
