#!/usr/bin/env raku

sub maximum-ones (+matrix) {
    matrix
    andthen .max: *.sum, :k
    andthen .head + 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is maximum-ones(<0 1>,<1 0>),1;
    is maximum-ones((0,0,0),(1,0,1)),2;
    is maximum-ones(0,0;1,1;0,0),2;
    done-testing;
}

multi MAIN (+matrix) {
    say maximum-ones matrix.map: *.comb.cache
}
