#!/usr/bin/env raku

use v6.d;

sub zero-array(Int:D @ints --> Int:D) {
    (grep { $_ > 0 }, unique @ints).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is zero-array(Array[Int:D].new((1, 5, 0, 3, 5))), 3, 'works for (1, 5, 0, 3, 5)';
    is zero-array(Array[Int:D].new((0))), 0, 'works for (0)';
    is zero-array(Array[Int:D].new((2, 1, 4, 0, 3))), 4, 'works for (2, 1, 4, 0, 3)';
}

#| Take user provided list like 1 17 8
multi sub MAIN(*@numbers where @numbers.elems ≥ 1) {
    my Int @int-nums = @numbers;
    say zero-array(@int-nums);
}

