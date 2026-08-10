#!/usr/bin/env raku
use Test;

is base-n(42, 2),         "101010";
is base-n(15642094, 16),  "EEADEE";
is base-n(493, 8),        "755";
is base-n(2228519, 36),   "1BRJB";
is base-n(123456789, 64), "7MyqL";

sub base-n($num, $base)
{
    my @a = flat 0..9, 'A'..'Z', 'a'..'z', '+', '/';
    [~] @a[ [R,] $num.polymod($base xx *) ]
}
