#!/usr/bin/env raku

sub flip-matrix (+matrix) {
    matrix .map: *.reverse »+^» 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply flip-matrix((1,1,0),(1,0,1),(0,0,0)),((1,0,0),(0,1,0),(1,1,1));
    is-deeply flip-matrix(
        [1, 1, 0, 0],
        [1, 0, 0, 1],
        [0, 1, 1, 1],
        [1, 0, 1, 0],
    ),(
        (1, 1, 0, 0),
        (0, 1, 1, 0),
        (0, 0, 0, 1),
        (1, 0, 1, 0),
    );
    done-testing;
}

multi MAIN (+matrix) {
    .put for flip-matrix matrix».split(',')
}
