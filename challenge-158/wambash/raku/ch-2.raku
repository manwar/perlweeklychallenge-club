#!/usr/bin/env raku

constant @first-series-cuban-primes = (
    1..∞
    andthen .map: -> \x  { 3*x² + 3*x +1}\
    andthen .grep: *.is-prime
);

multi MAIN (Bool :test($)!) {
    use Test;
    is @first-series-cuban-primes.toggle(* ≤ 1000), (7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919,);
    done-testing;
}

multi MAIN ($n=1000) {
    put @first-series-cuban-primes.toggle: * ≤ $n
}
