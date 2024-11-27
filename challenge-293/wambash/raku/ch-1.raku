#!/usr/bin/env raku

sub similar-dominos (+dominos) {
    dominos
    andthen .classify: *.Set
    andthen .grep: *.value.elems > 1
    andthen .map: *.value
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is similar-dominos([1, 3], [3, 1], [2, 4], [6, 8]), 2;
    is similar-dominos([1, 2], [2, 1], [1, 1], [1, 2], [2, 2]), 3;
    done-testing;
}

multi MAIN (+dminos) {
    say similar-dominos dminos».comb(/\d+/)
}
