#!/usr/bin/env raku

use v6.d;

sub compare-same-start(Int $a, Int $b --> Order) {
    my Str @a_chars = $a.comb;
    return @a_chars[0] cmp @a_chars[$b.chars];
}

sub compare-numbers(Int $a, Int $b --> Order) {
    return compare-same-start($a, $b) if $a.starts-with($b);
    return compare-same-start($b, $a) if $b.starts-with($a);
    return Str($a) cmp Str($b);
}

sub max-number(Int @numbers --> Int) {
    my @sorted-numbers = sort(&compare-numbers, @numbers).reverse;
    return Int(@sorted-numbers.join);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is max-number(Array[Int].new(1, 23)), 231, "works for (1, 23)";
    is max-number(Array[Int].new(10, 3, 2)), 3210, "works for (10, 3, 2)";
    is max-number(Array[Int].new(31, 2, 4, 10)), 431210, "works for (31, 2, 4, 10)";
    is max-number(Array[Int].new(5, 11, 4, 1, 2)), 542111, "works for (5, 11, 4, 1, 2)";
    is max-number(Array[Int].new(1, 10)), 110, "works for (1, 10)";
}

multi sub MAIN() {
    MAIN('test');
}

