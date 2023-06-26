#!/usr/bin/env raku

#| Given an integer N print the count of primes less than or equal to N
sub MAIN( Int() $n ) {
    (2..$n).grep( *.is-prime ).elems.say;
}
