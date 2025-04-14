#!/usr/bin/env raku
use Test;

ok  friendly-strings("desc", "dsec");
ok  friendly-strings("fuck", "fcuk");
nok friendly-strings("poo", "eop");
ok  friendly-strings("stripe", "sprite");
ok  friendly-strings("none", "none");    
nok friendly-strings("zero", "zero");
nok friendly-strings("four", "ofru");

multi friendly-strings($str1, $str2 where $str1 eq $str2)
{
    $str1 ~~ / (\w) .* $0 /
}

multi friendly-strings($str1, $str2)
{
    given ($str1.ords Z- $str2.ords).grep(*.so)
    {
        .elems == 2 and
        .sum   == 0 
    }
}
