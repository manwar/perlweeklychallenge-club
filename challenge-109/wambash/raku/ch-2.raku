#!/usr/bin/env raku

sub four-squares-puzzle ( +@n ) {
    @n.permutations
    andthen .pick: *
    andthen .map: *.rotor: 2 => -1, 3 => -1, 3 => -1, 2 => -1
    andthen .first: { [==] .cache.map: *.sum }
}


multi MAIN ( +@n ) {
    say four-squares-puzzle @n
}

multi MAIN (:test($)!) {
    use Test;
    is four-squares-puzzle(1..7).all.sum, 9|10|11 ;
    is four-squares-puzzle(2,-2,10,-8, 30, -22,+22).all.sum, 0 ;
    done-testing;
}
