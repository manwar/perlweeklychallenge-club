#!/usr/bin/env raku

use v6.d;

sub h-index(Int @citations --> Int) {
    my Int @sorted-citations = sort(@citations);
    my Int $index = 2;
    $index++ while @sorted-citations[* - $index] ≥ $index;
    return $index - 1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is h-index(Array[Int].new([10,8,5,4,3])), 4, 'works for (10,8,5,4,3)';
    is h-index(Array[Int].new([25,8,5,3,3])), 3, 'works for (25,8,5,3,3)';
}

#| Take user provided list like 1 2 2 3
multi sub MAIN(*@elements where @elements.elems ≥ 1 && all(@elements) ~~ /^0?<[1..9]><[0..9]>*$/) {
    my Int @int-elements = @elements;
    say "The h-index of ({@int-elements}) is: {h-index(@int-elements)}";
}
