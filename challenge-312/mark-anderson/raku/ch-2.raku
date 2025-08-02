#!/usr/bin/env raku
use Test;

is balls-and-boxes('G0B1R2R0B0'),         1;
is balls-and-boxes('G1R3R6B3G6B1B6R1G3'), 3;
is balls-and-boxes('B3B2G1B3'),           0;

sub balls-and-boxes($str)
{
    $str.comb
        .pairup
        .classify({ .value }, :as{ .key })
        .grep({ .value ⊇ <R G B> })
        .elems
}
