#!/bin/env raku

my @fibo = 1, 2, * + * ... *;

sub fibo-floor(UInt:D \n --> UInt:D) {
    (^n).grep({ @fibo[$_] ≤ n }).max
}

sub MAIN(UInt:D \n) {
    put @fibo[0 .. fibo-floor(n)].combinations.grep(*.sum == n).elems;
}
