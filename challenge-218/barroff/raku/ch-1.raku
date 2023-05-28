#!/usr/bin/env raku

use v6.d;

sub maximum-product(Int:D @numbers where @numbers.elems ≥ 3 --> Int) {
    return max(map({ [*] $_ }, @numbers.combinations(3)));
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is maximum-product(Array[Int].new(3, 1, 2)),
        6, "works for (3, 1, 2)";
    is maximum-product(Array[Int].new(4, 1, 3, 2)),
        24, "works for (4, 1, 3, 2)";
    is maximum-product(Array[Int].new(-1, 0, 1, 3, 1)),
        3, "works for (-1, 0, 1, 3, 1)";
    is maximum-product(Array[Int].new(-8, 2, -9, 0, -4, 3)),
        216, "works for (-8, 2, -9, 0, -4, 3)";
}

#| Take user provided list like 1 2 3
multi sub MAIN(*@numbers where @numbers.elems ≥ 3) {
    my Int @int-numbers = @numbers;
    say maximum-product(@int-numbers);
}

