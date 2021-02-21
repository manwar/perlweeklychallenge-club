#!/usr/bin/env raku

sub triangle-sum-reducer (@a, @b) {
    Inf, |@a, Inf
    andthen .rotor: 2 => -1
    andthen .map: *.min
    andthen $_ Z+ @b
}

sub triangle-sum ( +@a ) {
    @a
    andthen .reduce: &triangle-sum-reducer
    andthen .min
}

multi MAIN (Bool :$test!) {
    use Test;
    is triangle-sum-reducer( [1], [2,4] ), (3,5);
    is triangle-sum-reducer( [6,4,9], [5,1,7,2] ), (11,5,11,11);

    is triangle-sum( [3], [3,1], [5,2,3], [4,3,1,3] ), 7;
    is triangle-sum( [1], [2,4], [6,4,9], [5,1,7,2] ), 8;
    done-testing;
}
