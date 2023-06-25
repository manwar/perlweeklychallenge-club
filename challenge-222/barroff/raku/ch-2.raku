#!/usr/bin/env raku

use v6.d;

sub matching-members(Int:D @numbers --> Int) {
    my @sorted-numbers = sort(@numbers);
    grep( { @numbers[$_] == @sorted-numbers[$_]}, 0..@numbers.elems - 1 ).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is matching-members(Array[Int:D].new(1, 1, 4, 2, 1, 2)), 3,
        'works for (1, 1, 4, 2, 1, 2)';
    is matching-members(Array[Int:D].new(5, 1, 2, 3, 4)), 0,
        'works for (5, 1, 2, 3, 4)';
    is matching-members(Array[Int:D].new(1, 2, 3, 4, 5)), 5,
        'works for (1, 2, 3, 4, 5)';
}

#| Take user provided list like 1 17 8
multi sub MAIN(*@numbers where @numbers.elems ≥ 1) {
    my Int @int-numbers = @numbers;
    say matching-members(@int-numbers);
}
