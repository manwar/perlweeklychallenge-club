#!/usr/bin/env raku

constant @Factorial = 1, slip [\*] 1..* ;
constant @LeftFactorial = [\+]  @Factorial;

multi MAIN (Bool :test($)!) {
    use Test;
    is @LeftFactorial.head(10), (1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114);
    done-testing;
}

multi MAIN ($n = 10) {
    put @LeftFactorial.head($n);
}
