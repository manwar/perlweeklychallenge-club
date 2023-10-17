#!/usr/bin/env raku

sub persistence ( Int $n ) {
    $n, {[*] .comb } ... *.chars == 1
    andthen .elems
}

sub persistence-sort ( +int ) {
    int.sort: {.&persistence, $_ }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is persistence(99), 3;
    is persistence(25), 3;
    is persistence(15), 2;
    is persistence-sort(15, 99, 1, 34), (1, 15, 34, 99);
    is persistence-sort(50,25,33,22),(22, 33, 50, 25);
    done-testing;
}

multi MAIN (*@int) {
    put persistence-sort @int
}
