#!/usr/bin/env raku

sub is-long ( $n ) {
    1 / $n
    andthen .base-repeating[1]
    andthen .chars == $n - 1
}

sub is-long-prime ( $n ) {
    $n
    andthen .&is-long & .is-prime
    andthen .so
}

multi MAIN (Bool :test($)!){
    use Test;
    is is-long( 2),False;
    is is-long( 7), True;
    is is-long(17), True;
    is is-long-prime( 2),False;
    is is-long-prime( 7), True;
    is is-long-prime(17), True;
    done-testing;
}

multi MAIN ($n=5) {
    2..*
    andthen .grep: &is-long-prime
    andthen .head: $n
    andthen .batch: 5
    andthen .map: *.put
}
