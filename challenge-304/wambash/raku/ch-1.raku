#!/usr/bin/env raku
use v6.e.PREVIEW;

sub arrange-binary (+digits,:$n) {
    0,|digits,0
    andthen .snip: |(0,1) xx *
    andthen .skip: |(1,1) xx *                
    andthen .map: { .end div 2 }\
    andthen .sum ≥ $n
}

multi MAIN (Bool :test($)!) {
    use Test;
    is arrange-binary(1,0,0,0,1):1n, True;
    is arrange-binary(1,0,0,0,1):2n, False;
    is arrange-binary(1,0,0,0,0,1):2n, False;
    is arrange-binary(0,0,1,0,0,1):2n, False;
    is arrange-binary(0,0,1,0,0,):2n, True;
    done-testing;
}

multi MAIN (+digits) {
    say arrange-binary +digits
}
