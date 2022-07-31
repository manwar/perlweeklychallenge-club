#!/usr/bin/env raku

use Prime::Factor;

sub euler ($n) {
    prime-factors($n)
    andthen .Bag
    andthen .map: { (.key-1) * .key**(.value-1) }\
    andthen [*] $_
}

constant @euler = (^∞).map: &euler;

sub is-perfect-totient ($n) {
    $n == sum @euler[$n], { @euler[$_] } ... 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is is-perfect-totient(4375), True;
    is is-perfect-totient(5571), True;
    is is-perfect-totient(729), True;
    is is-perfect-totient(739),False;
    done-testing;
}

multi MAIN ($k=20) {
    3,5...∞
    andthen .grep: &is-perfect-totient
    andthen .head: $k
    andthen .Supply
    andthen .tap: *.put
}
