#!/usr/bin/env raku

sub triangle-sum-path (+@triangle) {
    @triangle
    andthen .map: *.min
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is triangle-sum-path( 1; 5,3; 2,3,4; 7,1,0,2; 6,4,5,2,8 ), 8;
    is triangle-sum-path( 5; 2,3; 4,1,5; 0,1,2,3; 7,2,4,1,9 ), 9;
    done-testing;
}

multi MAIN (+@triangle) {
    say triangle-sum-path @triangle.map: *.comb: /\d+/
}
