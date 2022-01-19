#!/usr/bin/env raku

constant @prime = ^Inf .grep: *.is-prime;

sub n-prime-number ($n=10001) {
    @prime
    andthen .skip: $n-1
    andthen .head
}

multi MAIN (Bool :test($)!) {
    use Test;
    is n-prime-number(1),2;
    is n-prime-number(2),3;
    is n-prime-number(6),13;
    is n-prime-number(), 104_743;
    done-testing;
}

multi MAIN ($n=10001) {
    say n-prime-number $n
}
