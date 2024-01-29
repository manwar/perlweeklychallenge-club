#!/usr/bin/env raku

sub weekest-row (+matrix) {
    matrix
    andthen .antipairs
    andthen .sort
    andthen .map: *.value
}

multi MAIN (Bool :test($)!) {
    use Test;
    my @matrix := [
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 0],
                   [1, 0, 0, 0, 0],
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 1]
                 ];
    is weekest-row(@matrix),(2,0,3,1,4);
    my @matrix2 := [
                   [1, 0, 0, 0],
                   [1, 1, 1, 1],
                   [1, 0, 0, 0],
                   [1, 0, 0, 0]
                 ];
    is weekest-row(@matrix2), (0,2,3,1);
    done-testing;
}

multi MAIN (+matrix) {
    put weekest-row matrix».comb: /\d/;
}
