#!/usr/bin/env raku

sub highest-row (+matrix) {
    matrix
    andthen .map: *.sum
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is highest-row(4 xx 4,(10,0,0,0),(2,2,2,9)), 16;
    is highest-row((1,5),(7,3),(3,5)), 10;
    is highest-row((1,2,3),(3,2,1)), 6;
    is highest-row((2,8,7),(7,1,3),(1,9,5)), 17;
    is highest-row((10,20,30),(5,5,5),(0,100,0), (25,25,25)), 100;
    done-testing;
}

multi MAIN (+matrix) {
    say highest-row matrix.map: *.comb: /\d+/ ;
}
