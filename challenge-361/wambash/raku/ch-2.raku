#!/usr/bin/env raku

sub find-celebrity (@matrix) {
    @matrix
    andthen [Z+] $_
    andthen .pairs
    andthen .first: { @matrix[.key].none and .value == @matrix.end }, :k
    orelse -1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is find-celebrity([[0,0,0,0,1,0],[0,0,0,0,1,0],[0,0,0,0,1,0],[0,0,0,0,1,0],[0,0,0,0,0,0],[0,0,0,0,1,0]]), 4, 'example 1';
    is find-celebrity([[0,1,0,0],[0,0,1,0],[0,0,0,1],[1,0,0,0]]), -1, 'example 2';
    is find-celebrity([[0,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0]]), 0, 'example 3';
    is find-celebrity([[0,1,0,1,0,1],[1,0,1,1,0,0],[0,0,0,1,1,0],[0,0,0,0,0,0],[0,1,0,1,0,0],[1,0,1,1,0,0]]), 3, 'example 4';
    is find-celebrity([[0,1,1,0],[1,0,1,0],[0,0,0,0],[0,0,0,0]]), -1, 'example 5';
    is find-celebrity([[0,0,1,1],[1,0,0,0],[1,1,0,1],[1,1,0,0]]), -1, 'example 6';
    done-testing;
}

multi MAIN (+@matrix) {
    say find-celebrity @matrix».comb(/\d/)».Int.map: *.cache;
}
