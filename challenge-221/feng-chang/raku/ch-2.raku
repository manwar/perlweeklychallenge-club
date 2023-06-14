#!/bin/env raku

unit sub MAIN(*@N where @N.all ~~ Int);

my method is-arithmetic-subsequence(@N : --> Bool:D) {
    return False if +@N < 2;
    [==] (^(+@N-1)).map({ @N[$_+1] - @N[$_] })
}

@N = +«@N;
put @N.combinations.grep(*.&is-arithmetic-subsequence)».elems.max;
