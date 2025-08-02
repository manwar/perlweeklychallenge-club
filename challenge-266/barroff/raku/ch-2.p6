#!/usr/bin/env raku

use v6.d;

sub x-matrix(@matrix --> Bool:D) {
   so True == map(
       { ($_[0] + $_[1] == @matrix.elems - 1) or ($_[0] == $_[1])
        ?? @matrix[$_[0]][$_[1]] ≠ 0
        !! @matrix[$_[0]][$_[1]] == 0 
       },
       cross((0..@matrix.elems - 1), (0..@matrix.elems - 1))
   ).all;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is x-matrix([ [1, 0, 0, 2],
                  [0, 3, 4, 0],
                  [0, 5, 6, 0],
                  [7, 0, 0, 1]
                 ]), True, 'works for matrix 1';
    is x-matrix([ [1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9],
                 ]), False, 'works for matrix 2';
    is x-matrix([ [1, 0, 2],
                  [0, 3, 0],
                  [4, 0, 5],
                 ]), True, 'works for matrix 3';
}
