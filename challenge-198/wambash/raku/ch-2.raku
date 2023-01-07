#!/usr/bin/env raku

sub prime-count ($n) {
    ^Inf
    andthen .grep: *.is-prime
    andthen .toggle: { $_ < $n }\
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is prime-count(10), 4;
    is prime-count(15), 6;
    is prime-count( 1), 0;
    is prime-count(25), 9;
    done-testing;
}

multi MAIN ($n) {
    say prime-count $n
}
