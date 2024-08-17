#!/usr/bin/env raku
use Test;

is twice-appearance("acbddbca"), "d";
is twice-appearance("abccd"),    "c";
is twice-appearance("abcdabbb"), "a";

sub twice-appearance($str)
{
    $str.comb.repeated.first
}
