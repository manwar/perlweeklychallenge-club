#!/usr/bin/env raku

use v6.d;

sub order-pairs(Int @list where @list.elems > 1 --> List) {
    (@list[1..*] Z<=> @list[0..*-1]).list;
}

sub is-monotonic(Order @comparisons --> Bool) {
    my Junction $junc = @comparisons.any;
    (More == $junc and Less == $junc) ?? False !! True;
}

sub monotonic-array(Int @elements --> Int) {
    my Order @orders = order-pairs(@elements);
    return is-monotonic(@orders) ?? 1 !! 0;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is monotonic-array(Array[Int].new([1, 2, 2, 3])), 1, 'works for (1, 2, 2, 3)';
    is monotonic-array(Array[Int].new([1, 3, 2])), 0, 'works for (1, 3, 2)';
    is monotonic-array(Array[Int].new([6, 5, 5, 4])), 1, 'works for (6, 5, 5, 4)';
}

#| Take user provided list like 1 2 2 3
multi sub MAIN(*@elements where all(@elements) ~~ /^<[+-]>?<[0..9]>+$/) {
    my Int @int_elements = @elements;
    monotonic-array(@int_elements) ?? say 1 !! say 0;
}
