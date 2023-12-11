#!/usr/bin/env raku
use Test;

is most-freq-pair("abcdbca"),           "bc";
is most-freq-pair("cdeabeabfcdfabgcd"), "ab";

sub most-freq-pair($str)
{
    ($str ~~ m:ov/../)>>.Str.Bag.maxpairs.sort.head.key
}
