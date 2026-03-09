#!/usr/bin/env raku
use Test;

is decrypt-string("10#11#12"),  "jkab";
is decrypt-string("1326#"),     "acz";
is decrypt-string("25#24#123"), "yxabc";
is decrypt-string("20#5"),      "te";
is decrypt-string("1910#26#"),  "aijz";

sub decrypt-string($str)
{
    $str.trans((flat 1..9, (10..26) >>~>> '#') => 'a'..'z')
}
