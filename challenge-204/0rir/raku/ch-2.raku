#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ « ␤ » ∴
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
204-2: Reshape Matrix       Submitted by: Mohammad S Anwar

Given a matrix (m x n) and two integers (r) and (c), reshape that matrix in form
(r x c) with the original value in the given matrix. If you can’t reshape print 0.

Example 1
Input: [ 1 2 ]
       [ 3 4 ]

       $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
       $r = 1
       $c = 4

Output: [ 1 2 3 4 ]
Example 2
Input: [ 1 2 3 ]
       [ 4 5 6 ]

       $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
       $r = 3
       $c = 2

Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]

        [ 1 2 ]
        [ 3 4 ]
        [ 5 6 ]
Example 3
Input: [ 1 2 ]

       $matrix = [ [ 1, 2 ] ]
       $r = 3
       $c = 2

Output: 0
=end comment

my @Test = 
    [ [ [1,2],[3,4]], 1, 4, [1,2,3,4] ],
    [ [ [1,2,3],[4,5,6]], 3, 2, [ [1,2],[3,4],[5,6]] ],

    [ [ 1,2 ], 3, 2, Array ],
    [ [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 5, Array ],
    [ [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 5, 3, Array ],

    [ [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 1, 18,
      [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    ],
    [ [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 2, 9,
      [[1,2,3,4,5,6,7,8,9],[10,11,12,13,14,15,16,17,18]]
    ],
    [ [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 3, 6,
      [[1,2,3,4,5,6],[7,8,9,10,11,12],[13,14,15,16,17,18]]
    ],
    [ [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 6, 3,
      [[1,2,3],[4,5,6],[7,8,9],[10,11,12],[13,14,15],[16,17,18]]
    ],
    [ [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 9, 2,
      [[1,2],[3,4],[5,6],[7,8],[9,10],[11,12],[13,14],[15,16],[17,18]]
    ],
    [ [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 18, 1,
    [[1,],[2,],[3,],[4,],[5,],[6,],[7,],[8,],[9,],[10,],[11,],[12,],[13,],[14,],[15,],[16,],[17,],[18,]]
    ],
;

enum Fields < Matrix Rows Cols Exp >;

multi reshape-matrix( @matrix, $rows, $cols --> Array ) {
    my @m = @matrix;
    @m = @m».List.flat;
    return Array if @m.elems ≠ $rows × $cols;
    (@matrix».List.flat.rotor( $rows)».Array).Array;
}

plan +@Test;
for @Test -> @t {
    is reshape-matrix(@t[Matrix], @t[Rows], @t[Cols]), @t[Exp];
}
done-testing;



