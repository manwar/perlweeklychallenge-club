#!/usr/bin/env raku
use Test;

is completing-word("aBc 11c", <accbbb abc abbc>),   "accbbb";
is completing-word("Da2 abc", <abcm baacd abaadc>), "baacd";
is completing-word("JB 007",  <jj bb bjb>),         "bjb";
is completing-word("JB 007",  <ab cd ef>),          "";

sub completing-word($str, @arr)
{
    my $bag = $str.lc.comb(/<lower>/).Bag;
    @arr.sort(*.chars).first($bag (<=) *.comb.Bag) // ~Empty
}
