#!/usr/bin/env raku

use Test;
plan 2;

is swap-nibbles(101), 86;
is swap-nibbles(18),  33;

sub swap-nibbles($N where * > 0)
{
    $N.fmt('%08b').comb(4).rotate.join.parse-base(2)
}
