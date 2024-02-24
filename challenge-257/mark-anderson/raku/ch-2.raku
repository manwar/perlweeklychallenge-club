#!/usr/bin/env raku
use v6.e.PREVIEW; # for snip
use Test;

ok  RREF([
             [1, 0, 0, 1],
             [0, 1, 0, 2],
             [0, 0, 1, 3]
         ]);

nok RREF([
             [1, 1, 0],
             [0, 1, 0],
             [0, 0, 0]
         ]);

ok  RREF([
             [0, 1,-2, 0, 1],
             [0, 0, 0, 1, 3],
             [0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0]
         ]);

ok  RREF([
             [1, 0, 0, 4],
             [0, 1, 0, 7],
             [0, 0, 1,-1]
         ]);

nok RREF([
             [0, 1,-2, 0, 1],
             [0, 0, 0, 0, 0],
             [0, 0, 0, 1, 3],
             [0, 0, 0, 0, 0]
         ]);

nok RREF([
             [0, 1, 0],
             [1, 0, 0],
             [0, 0, 0]
         ]);

nok RREF([
             [4, 0, 0, 0],
             [0, 1, 0, 7],
             [0, 0, 1,-1]
         ]);

nok RREF([
             [1, 0, 0, 0],
             [0, 1, 0, 3],
             [0, 0, 1,-3],
             [0, 0, 0, 1],
             [0, 0, 0, 0]
         ]);

nok RREF([
             [1, 0, 0, 0],
             [0, 1, 0, 1],
             [0, 0, 1, 0],
             [0, 0, 0, 1],
             [0, 0, 0, 0]
         ]);

ok  RREF([
             [1, 0, 0, 0, 0],
             [0, 1, 0, 0, 0],
             [0, 0, 0, 0, 1],
             [0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0]
         ]);

ok  RREF([
             [0, 0, 0],
             [0, 0, 0],
             [0, 0, 0],
             [0, 0, 0]
         ]);

ok  RREF([
             [0, 0, 0],
         ]);

ok  RREF([
             [0, 1, 0],
         ]);

nok RREF([
             [5],
         ]);

multi RREF(@m where all(.head) == 0)
{
    all @m[1..*].map(*.all == 0)
}

multi RREF(@m)
{
    # group rows according to whether they are all-zero or not 
    @m .= snip(|(*.any, *.any.not) xx *); 

    # at least one all-zero row occurs in the middle
    return False if @m.elems > 2;

    # remove any all-zero rows grouped at the bottom
    @m = @m[0;*];

    # the first non-zero number in a row is the pivot. store the indices in @cols
    my @cols = @m>>.first(*.any, :k);

    # the pivots go from top-left to bottom-right
    return False unless [<] @cols;

    # remove any non-pivot columns
    @m = @m[*;@cols].batch(@cols.elems)>>.Array;

    # @m will be an identity matrix now if it was in reduced row echelon form
    # 🤓

    # all pivots are ones
    return False unless all(@m.keys.map({ |@m[$_].splice($_,1) })) == 1;

    # everything else is a zero
    return all(@m[*;*]) == 0
}
