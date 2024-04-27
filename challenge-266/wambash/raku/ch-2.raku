#!/usr/bin/env raku

sub x-matrix (+matrix) {
    my $n = matrix.elems;
    my @x-index = ( (^$n Z=> ^$n) Z, (^$n Z=> reverse ^$n) andthen .map: { set |$_  } );

    matrix
    andthen .pairs
    andthen .map: { set  .key «=>« |.value.grep: * !== 0,:k }\
    andthen $_ Z≡ @x-index
    andthen .all
}

multi MAIN (Bool :test($)!) {
    use Test;

    is x-matrix(
        [1, 0, 0, 2],
        [0, 3, 4, 0],
        [0, 5, 6, 0],
        [7, 0, 0, 1],
    ), True;

    is x-matrix(
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
    ), False;

    is x-matrix(
        [1, 0, 2],
        [0, 3, 0],
        [4, 0, 5],
    ), True;

    done-testing;
}

multi MAIN (+matrix) {
    say ?x-matrix matrix.map: *.comb: /\d+/
}
