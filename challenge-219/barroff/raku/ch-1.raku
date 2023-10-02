#!/usr/bin/env raku

use v6.d;

sub sorted-powers(Int:D @numbers where @numbers.elems ≥ 1, Int:D $n --> List) {
    sort(map({ $_ ** $n }, @numbers)).list;
}

sub sorted-squares(Int:D @numbers --> List) {
    sorted-powers(@numbers, 2);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is sorted-squares(Array[Int:D].new((-2, -1, 0, 3, 4))),
        (0, 1, 4, 9, 16), 'works for (-2, -1, 0, 3, 4)';
    is sorted-squares(Array[Int:D].new((5, -4, -1, 3, 6))),
        (1, 9, 16, 25, 36), 'works for (5, -4, -1, 3, 6)';
}

#| Take user provided list like 1 2 3
multi sub MAIN(*@numbers where @numbers.elems ≥ 1) {
    my Int @int-numbers = @numbers;
    say sorted-squares(@int-numbers);
}


