#!/usr/bin/env raku
use Test;

is reverse-letters("p-er?l"), "l-re?p";
is reverse-letters("wee-k!L-y"), "yLk-e!e-w";
is reverse-letters("_c-!h_all-en!g_e"), "_e-!g_nel-la!h_c";

sub reverse-letters($str)
{
    my @s = $str.comb;
    my @k = @s.grep(/:i <[a..z]>/, :k);
    @s[@k] = @s[@k].reverse;
    [~] @s
}
