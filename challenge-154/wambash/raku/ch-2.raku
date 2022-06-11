#!/usr/bin/env raku

constant @Padovan = 1,1,1, -> $a, $b, $ {$a + $b}  ... *;
constant @PadovanPrime = @Padovan.grep(*.is-prime).squish;

multi MAIN (Bool :test($)!) {
    use Test;
    is @Padovan.head(15), (1, 1, 1, 2, 2, 3, 4, 5, 7, 9, 12, 16, 21, 28, 37), 'first few Padovan Numbers' ;
    is @PadovanPrime.head(10),(2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057), 'first 10 distinct Padovan Primes' ;
    done-testing;
}

multi MAIN ($n=10) {
    put @PadovanPrime.head($n)
}
