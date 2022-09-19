#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢ ⊗
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
Task 2: Kronecker Product   Submitted by: Mohammad S Anwar

You are given 2 matrices.

Write a script to implement Kronecker Product on the given 2 matrices.
For more information, please refer wikipedia page.

A = [ 1 2 ]
    [ 3 4 ]

B = [ 5 6 ]
    [ 7 8 ]
0
A x B = [ 1x5 1x6 2x5 2x6 ]
        [ 1x7 1x8 2x7 2x8 ]
        [ 3x5 3x6 4x5 4x6 ]
        [ 3x7 3x8 4x7 4x8 ]
=end comment

my constant TEST = False;

if TEST {
    my @Test =
        {   L => [], R => [], E => [],
        },
        {   L => [[ 1, ], [ 2,]],    R => [[ 3, ], [ 4,]],
            E => [[ 3,], [ 4,], [ 6,], [ 8,]],
        },
        {   L => [[ 1, 2 ], [ 3, 4 ]],    R => [[ 5, 6 ], [ 7, 8 ]],
            E => [[  5,6,10,12 ], [ 7,8,14,16 ], [ 15,18,20,24 ], [ 21,24,28,32 ]],
        },
        {   L => [[ 1, 2, 3, 0], [2,3,4,5]],
            R => [[ 6,7,8 ], [0,10,11]],
            E => [[ 6,7,8, 12,14,16, 18,21,24, 0,0,0],
                 [ 0,10,11,  0,20,22,  0,30,33, 0,0,0],
                 [ 12,14,16, 18,21,24, 24,28,32, 30,35,40],
                 [ 0,20,22,  0,30,33,  0,40,44, 0,50,55]],
        },
        ;

    plan @Test.elems;

    for @Test -> %t {
        is-deeply kronecker( %t<L>, %t<R>), %t<E>;
    }
    done-testing;
    exit;
}

my @L = [ 1, 2 ], [ 3, 4 ];
my @R = [ 5, 6 ], [ 7, 8 ];

sub kronecker( @l, @r ) {
    my @ret;
    for @l -> @mult {
        for @r -> @plier {
            @ret.push( [ @mult X* @plier ] );
        }
    }
    @ret;
}

say kronecker( @L, @R);




