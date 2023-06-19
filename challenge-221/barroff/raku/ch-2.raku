#!/usr/bin/env raku

use v6.d;

sub is-arithmetic(@numbers --> Bool) {
    my Int @diffs = map({ @numbers[$_ - 1] - @numbers[$_] }, 1..@numbers.elems - 1);
    return so @diffs[0] == @diffs.all;
}

sub check-sequences(@numbers, Int:D $k --> Bool) {
    so map(&is-arithmetic, combinations(@numbers, $k)).any;
}


sub arithmetic-subsequence(Int:D @numbers where @numbers.elems ≥ 1 --> Int) {
    for (@numbers.elems...1) -> $k {
        return $k if check-sequences(@numbers, $k);
    }
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is arithmetic-subsequence(Array[Int].new(9, 4, 7, 2, 10)),
        3, "works for (9, 4, 7, 2, 10)";
    is arithmetic-subsequence(Array[Int].new(3, 6, 9, 12)),
        4, "works for (3, 6, 9, 12)";
    is arithmetic-subsequence(Array[Int].new(20, 1, 15, 3, 10, 5, 8)),
        4, "works for (20, 1, 15, 3, 10, 5, 8)";
}

#| Take user provided list like 1 2 3
multi sub MAIN(*@numbers where @numbers.elems ≥ 2) {
    my Int @int-numbers = @numbers;
    say arithmetic-subsequence(@int-numbers);
}


