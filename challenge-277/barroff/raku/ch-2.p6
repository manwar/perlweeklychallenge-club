#!/usr/bin/env raku

use v6.d;

sub is-strong-pair(Int $x, Int $y --> Bool) {
    return False if $x == $y;
    return abs($x - $y) < min($x, $y);
}

sub strong-pair(@ints --> Int) {
    my @uniq_ints = unique(@ints);
    grep(
        { is-strong-pair($_[0], $_[1]) },
        @uniq_ints.combinations: 2
    ).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is strong-pair([1, 2, 3, 4, 5]), 4, 'works for [1, 2, 3, 4, 5]';
    is strong-pair([5, 7, 1, 7]), 1, 'works for [5, 7, 1, 7]';
}

#| Take user provided number like 1024 512 256 128 64
multi sub MAIN(*@ints) {
    say strong-pair(@ints);
}
