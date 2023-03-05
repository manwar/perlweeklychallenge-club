#!/usr/bin/env raku

use v6.d;

sub array-pairings(Int @array --> Int) {
    my Int @sorted-array = sort(@array);
    my Int @even-indices = grep({ $_ % 2 == 0 }, 0 ..^ @array.elems);
    return sum(@sorted-array[@even-indices]);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is array-pairings(Array[Int].new([1, 2, 3, 4])), 4, 'works for (1, 2, 3, 4)';
    is array-pairings(Array[Int].new([0, 2, 1, 3])), 2, 'works for (0, 2, 1, 3)';
}

#| Take user provided list like 1 2 2 3
multi sub MAIN(*@elements where @elements.elems ≥ 2 && @elements.elems % 2 == 0 && all(@elements) ~~ /^<[+-]>?<[0..9]>+$/) {
    my Int @int-elements = @elements;
    say array-pairings(@int-elements);
}
