#!/usr/bin/env raku

sub search-insert-position (+@n, :$n) {
    @n
    andthen .toggle: * < $n
    andthen .elems
}

multi MAIN (Bool :$test!) {
    use Test;
    is search-insert-position(1,2,3,4):3n, 2;
    is search-insert-position(1,3,5,7):6n, 3;
    is search-insert-position(12,14,16,18):10n, 0;
    is search-insert-position(11,13,15,17):19n, 4;
    done-testing;
}

multi MAIN (*@n, :$n) {
    say search-insert-position @n, :$n
}
