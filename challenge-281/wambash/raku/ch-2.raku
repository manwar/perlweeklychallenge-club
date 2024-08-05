#!/usr/bin/env raku
use v6.e.PREVIEW;
use Graph;


enum Col (<a>..<h>);
enum Row (1 => 1, slip 2..8);

constant @vertices = Col::.values.sort X, Row::.values.sort;

sub move ( @ (Col $col, Row $row), @ ($col-diff,$row-diff) ) {
    try { Col($col+$col-diff), Row($row+$row-diff) }\ 
    orelse Empty
}

sub knight-jump ( +@vertex (Col $, Row $) ) {
    -1, 1  X,  -2, 2
    andthen .map: { slip $_, .reverse }\
    andthen .map: &move.assuming(@vertex)\
}

constant %adjacency-list = %(
    @vertices.map: { $_.join => set knight-jump($_).map: *.join  }\
);

constant knight-moves = Graph.new(
    :%adjacency-list
);

sub knight's-move ($start, $end) {
    knight-moves.find-shortest-path: $start, $end
    andthen .elems - 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is knight-jump( g, Row(2) ), ((e,Row(1)),(f,Row(4)),(e,Row(3)),(h,Row(4)),);
    is knight-jump( c, Row(4) ), ((b,Row(2)),(a,Row(3)),(b,Row(6)),(e,Row(3)),(d,Row(2)),(a,Row(5)),(d,Row(6)),(e,Row(5)));
    is knight's-move('g2','a8'), 4;
    is knight's-move('g2','h2'), 3;
    is knight's-move('g2','h4'), 1;
    is knight's-move('g2','g6'), 2;
    done-testing;
}

multi MAIN ($start, $end) {
    say knight's-move $start, $end
}
