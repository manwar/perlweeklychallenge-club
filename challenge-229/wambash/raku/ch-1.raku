#!/usr/bin/env raku

subset Lexicographic where { [ge] .comb  or  [le] .comb  };

sub lexicographic-order (+str) {
    str
    andthen .grep: Lexicographic
    andthen  (str.elems - .elems) but .List
}

multi MAIN (Bool :test($)!) {
    use Test;
    isa-ok $_, Lexicographic for <abc bce cba xyz zok>;
    cmp-ok $_, '!~~', Lexicographic for <cae mon yxz>;
    is lexicographic-order(<abc bce cae>).List, <abc bce>;
    is lexicographic-order(<abc bce cae>), 1;
    is lexicographic-order(<yxz cba mon>), 2;
    is lexicographic-order(<yxz cba mon>).List, <cba>;
    done-testing;
}

multi MAIN (+str) {
    say lexicographic-order str
}
