#!/usr/bin/env raku

sub number-game (+ints) {
    ints
    andthen .sort
    andthen .map: {slip $^b, $^a}
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply number-game(2,5,3,4),(3,2,5,4);
    is-deeply number-game(9, 4, 1, 3, 6, 4, 6, 1),(1, 1, 4, 3, 6, 4, 9, 6);
    is-deeply number-game((1, 2, 2, 3)),(2, 1, 3, 2);
    done-testing;
}

multi MAIN (+ints) {
    put number-game ints
}
