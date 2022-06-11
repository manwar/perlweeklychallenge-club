#!/usr/bin/env raku

constant @additive-primes = (
    2..∞
    andthen .grep: *.is-prime
    andthen .grep: *.comb.sum.is-prime
);


multi MAIN (Bool :test($)!) {
    use Test;
    is @additive-primes.toggle(* ≤ 100), (2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89);
    done-testing;
}

multi MAIN ($n=1000) {
    put @additive-primes.toggle: * ≤ $n
}
