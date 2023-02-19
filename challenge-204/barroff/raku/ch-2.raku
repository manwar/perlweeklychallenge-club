#!/usr/bin/env raku

use v6.d;

sub can-reshape(List $list, Int $rows, Int $columns --> Bool) {
    $list.elems == $rows × $columns;
}

sub reshape-matrix(List $list, Int $rows where $rows ≥ 1, Int $columns where $columns ≥ 1 --> List) {
    my List $flat-list = $list.flat.list;
    my List $result = ();
    if can-reshape($flat-list, $rows, $columns) {
        $result = ( $flat-list[($_ × $columns) ..^ ($_ + 1) × $columns] for 0 ..^ $rows );
    }
    say '0' unless $result;
    return $result;
}

sub MAIN {
    use Test;
    plan 3;

    is reshape-matrix(((1, 2), (3, 4)), 1, 4), (1, 2, 3, 4), 'matrix ((1, 2), (3, 4))';
    is reshape-matrix(((1, 2, 3), (4, 5, 6)), 3, 2), ((1, 2), (3, 4), (5, 6)), 'matrix ((1, 2, 3), (4, 5, 6))';
    is reshape-matrix(((1, 2)), 3, 2), (), 'matrix ((1, 2))';
}
