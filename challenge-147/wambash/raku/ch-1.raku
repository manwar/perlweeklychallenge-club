#!/usr/bin/env raku
constant @primes = (
    ^Inf
    andthen .grep: *.is-prime
);


sub truncable-prime ($n) {
   $n.chars == $n.match: / <[1..9]>+ $ <?{$/.is-prime}> /,:ov
}

constant @truncable-primes = (
    @primes
    andthen .grep: *.&truncable-prime
);

multi MAIN (Bool :test($)!) {
    use Test;
    is truncable-prime(9137), True;
    is @truncable-primes.head(20), (2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197);
    done-testing;
}

multi MAIN ( $n=20 ) {
    put @truncable-primes.head($n)
}
