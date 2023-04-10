#!/usr/bin/env raku

sub toeplitz-matrix (+@matrix) {
    @matrix
    andthen .rotor: 2 => -1
    andthen .map: -> (@x,@y) { @x.head(*-1) eqv @y.tail(*-1) }\
    andthen .all
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply toeplitz-matrix([4, 3, 2, 1], [5, 4, 3, 2],[6, 5, 4, 3],),True;
    is-deeply toeplitz-matrix([1,2,3],[3, 2, 1],),False;
    done-testing;
}

multi MAIN (*@matrix) {
    say ?toeplitz-matrix @matrix.map: *.comb: /\d+/
}
