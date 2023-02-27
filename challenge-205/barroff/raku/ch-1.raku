#!/usr/bin/env raku

use v6.d;

sub third-highest(Int @list where @list.elems > 1 --> Int) {
    my Int @sorted = @list.unique.sort;
    @sorted.elems ≥ 3 ?? @sorted[* - 3] !! @sorted[* - 1];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is third-highest(Array[Int].new([5, 3, 4])), 3, 'works for (5, 3, 4)';
    is third-highest(Array[Int].new([5, 6])), 6, 'works for (5, 6)';
    is third-highest(Array[Int].new([5, 4, 4, 3])), 3, 'works for (5, 4, 4, 3)';
}

#| Take user provided list like 1 2 2 3
multi sub MAIN(*@elements where @elements.elems ≥ 1 && all(@elements) ~~ /^<[+-]>?<[0..9]>+$/) {
    my Int @int_elements = @elements;
    say third-highest(@int_elements);
}

#| Run test cases if no argument is supplied
multi sub MAIN() {
    MAIN('test');
}
