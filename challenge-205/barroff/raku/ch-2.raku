#!/usr/bin/env raku

use v6.d;

sub maximum-xor(Int @list where @list.elems > 1 --> Int) {
    my Int @unique-list = @list.unique;
    my @pairs = map({ $_[0] +^ $_[1] }, @unique-list.combinations(2));
    return max(@pairs);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is maximum-xor(Array[Int].new([1 , 2, 3, 4, 5, 6, 7])), 7, 'works for (1, 2, 3, 4, 5, 6, 7)';
    is maximum-xor(Array[Int].new([2 , 4, 1, 3])), 7, 'works for (2, 4, 1, 3)';
    is maximum-xor(Array[Int].new([10 , 5, 7, 12, 8])), 15, 'works for (10, 5, 7, 12, 8)';
}

#| Take user provided list like 1 2 2 3
multi sub MAIN(*@elements where @elements.elems ≥ 1 && all(@elements) ~~ /^<[+-]>?<[0..9]>+$/) {
    my Int @int_elements = @elements;
    say maximum-xor(@int_elements);
}
