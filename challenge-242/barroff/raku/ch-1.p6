#!/usr/bin/env raku

use v6.d;

sub missing-members(Int:D @arr1, Int:D @arr2 --> List:D) {
    my Set[Int] $set1 = Set[Int](@arr1);
    my Set[Int] $set2 = Set[Int](@arr2);
    return ($set1 (-) $set2, $set2 (-) $set1);
}

#| Run test cases
sub MAIN() {
    use Test;
    plan 2;

    is-deeply missing-members(Array[Int](1, 2, 3), Array[Int](2, 4, 6)),
        (Set[Int](1, 3), Set[Int](4, 6)),
        'works for (1, 2, 3)    and (2, 4, 6)';
    is-deeply missing-members(Array[Int](1, 2, 3, 3), Array[Int](1, 1, 2, 2)),
        (Set[Int](3), Set[Int].new()),
        'works for (1, 2, 3, 3) and (1, 1, 2, 2)';
}
