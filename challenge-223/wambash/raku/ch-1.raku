#!/usr/bin/env raku

constant @PRIMES := ^∞ .grep: &is-prime;

sub count-primes ($n) {
    @PRIMES
    andthen .toggle: * < $n
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is count-primes(10), 4;
    is count-primes(1), 0;
    is count-primes(20), 8;
    done-testing;
}

multi MAIN ($n) {
    say count-primes $n
}
