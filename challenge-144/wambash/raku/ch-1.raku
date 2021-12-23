#!/usr/bin/env raku

constant @primes = (2 ... *).grep: *.is-prime;
constant @semiprimes = (
    @primes
    andthen [\,] $_
    andthen .map: {$_ X* .tail}\
);

sub semiprime ($n) {
    @semiprimes
    andthen .map: { .toggle: * ≤ $n }\
    andthen .toggle: * !~~ Empty
    andthen .map: |*
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply semiprime(100).Set, set(4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39, 46, 49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93, 94, 95);
    done-testing;
}

multi MAIN ($n = 100) {
    semiprime $n
    andthen .batch: 20
    andthen .map: *.fmt('%5d').put
}
