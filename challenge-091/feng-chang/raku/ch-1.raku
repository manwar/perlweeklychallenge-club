#!/bin/env raku

sub MAIN(UInt:D $N) {
    my @n = $N.comb».UInt;

    ((^@n.elems) X (^@n.elems))                             # all possible ranges
        .grep({ .[1] ≥ .[0] })                                      # end point of range should be greater or equal to start point
        .grep({ [==] @n[.[0] .. .[1]] })                            # all digits within the range should be the same
        .grep({ .[0] == 0 or @n[.[0]-1] != @n[.[0]] })              # filter sub-ranges with left  margin condition
        .grep({ .[1] == @n.elems-1 or @n[.[1]] != @n[.[1]+1] })     # fliter sub-ranges with right margin condition
        .map({ "{ .[1] - .[0] + 1 }{ @n[.[0]] }" })                 # output each range
        .join
        .put;
}
