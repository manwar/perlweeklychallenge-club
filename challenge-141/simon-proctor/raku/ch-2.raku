#!/usr/bin/env raku

#| Given a two number M and N find the number of "Like Numbers" can be found
sub MAIN (
    UInt \M, #= Integer used to make sub values
    UInt \N  #= Integer subvales of M should be divisible by
) {
    M.comb.combinations(1..^(M.codes)).map( *.join() ).grep( * %% N ).elems.say;
}
