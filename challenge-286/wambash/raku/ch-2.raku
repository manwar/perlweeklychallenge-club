#!/usr/bin/env raku

sub order-game-step (@ints) {
    cache @ints.map: -> $a, $b, $c?, $d? { slip $a min $b, $c max $d }
}

sub order-game (+ints) {
    ints
    andthen .list, &order-game-step ... *.tail eq -Inf
    andthen .tail
    andthen .head
}

multi MAIN (Bool :test($)!) {
    use Test;
    is order-game(2, 1, 4, 5, 6, 3, 0, 2), 1;
    is order-game(0, 5, 3, 2), 0;
    is order-game(9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8), 2;
    done-testing;
}

multi MAIN (+ints) {
    say order-game ints
}
