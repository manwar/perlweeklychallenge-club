#!/bin/env raku

unit sub MAIN(UInt:D \n);

sub is-stealthy(UInt:D \n --> Bool:D) {
    (1..sqrt(n).Int)
        .grep(n %% *)
        .map({ [$_, n div $_] })
        .combinations(2)
        .grep({ abs(.[0].sum - .[1].sum) == 1 })
        .elems
    > 0
}

put +is-stealthy(n);
