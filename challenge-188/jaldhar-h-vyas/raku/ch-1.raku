#!/usr/bin/raku

sub MAIN(
    Int $k, #= divisor
    *@list  #= list of integers
) {
    (0 ..^ @list.elems)
        .combinations(2)
        .grep({ @$_.sum %% $k})
        .elems
        .say;
}