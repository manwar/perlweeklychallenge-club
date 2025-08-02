#!/bin/env raku

unit sub MAIN(Str:D $str, *@strs);

my %seed = $str.lc.comb.grep('a'..'z').Bag;
put @strs.grep(*.comb.Bag (>=) %seed).first(*.chars);
