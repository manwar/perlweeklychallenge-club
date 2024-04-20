#!/usr/bin/env raku
use v6.e.PREVIEW;

sub appearance (+ints, :$p=1/3) {
    ints
    andthen .Mix
    andthen .nodemap: { $^x / $_ }\
    andthen .grep: { .value ≥ $p }\
    andthen .min: *.key
    andthen .?key
}

multi MAIN (Bool :test($)!) {
    use Test;
    is appearance(1,2,3,3,3,3,4,2),3;
    is appearance(1,1),1;
    is appearance(1,2,3),1;
    is appearance(1,2,3,4),Nil;
    is appearance(1,2,3,4):p(1/4),1;
    is appearance(3,4,5,5),5;
    done-testing;
}

multi MAIN (+ints, :$p=1/3) {
    say appearance ints, :$p
}
