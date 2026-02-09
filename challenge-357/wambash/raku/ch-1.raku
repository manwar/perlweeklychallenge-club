#!/usr/bin/env raku

multi kaprekar-constant ($int where {[==] .comb }) {
    Nil
}

multi kaprekar-constant ($int) {
    $int, {
        .comb.sort.join
        andthen .flip - $_
        andthen .fmt: '%04d'
    } ... 6174
    andthen .end
}

multi MAIN (Bool :test($)!) {
    use Test;
    is kaprekar-constant(3524), 3;
    is kaprekar-constant(1001), 4;
    is kaprekar-constant(9998), 5;
    is kaprekar-constant(9000), 4;
    is kaprekar-constant(6174), 0;
    is kaprekar-constant(1111), Nil;
    done-testing;
}

multi MAIN ($int) {
    say kaprekar-constant($int) // -1;
}
