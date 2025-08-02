#!/usr/bin/env raku

multi maximal-square ( +@matrix, :from((0,0)) ) {
    my $rows = @matrix.elems;
    my $colums = @matrix[0].elems;
    my $max-square = $rows min $colums;

    $max-square ... 1
    andthen .map: { @matrix[^$_;^$_] }\
    andthen .first: { .sum == .elems }\
    andthen .sum
    orelse 0
}

multi maximal-square (+@matrix, :from(($r,$c))!) {
    @matrix
    andthen .skip: $r
    andthen .map: { .skip: $c }\
    andthen maximal-square($_,:from(0,0))
}

multi maximal-square (+@matrix) {
    my $rows = @matrix.elems;
    my $colums = @matrix[0].elems;

    ^$rows X ^$colums
    andthen .map: { maximal-square @matrix, :from($_) }\
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    my @matrix = ([1, 0, 1, 0, 0],
                  [1, 0, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 0, 0, 1, 0]);
    is maximal-square(@matrix),4;
    is maximal-square([1,1],[1,1], :from(0,0)),4;
    is maximal-square([1,1],[1,1]),4;
    is maximal-square([0,1],[1,0]),1;
    is maximal-square([0,0],[1,0]),1;
    is maximal-square([0,0],[0,0]),0;
    is maximal-square([0,0],[0,1]),1;
    is maximal-square([0,1,1],[1,1,1],[0,1,1],[1,1,1]), 4;
    is maximal-square(([0],)),0;
    done-testing;
}

multi MAIN (+@matrix) {
    say maximal-square @matrix.map: *.comb(/\d+/).cache
}
