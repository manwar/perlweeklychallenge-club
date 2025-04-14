#!/usr/bin/env raku
use Test;

ok  friendly-strings("desc", "dsec");
ok  friendly-strings("fuck", "fcuk");
nok friendly-strings("poo", "eop");
ok  friendly-strings("stripe", "sprite");
nok friendly-strings("none", "none");
nok friendly-strings("four", "ofru");

sub friendly-strings($str1, $str2)
{
    given ($str1.ords Z- $str2.ords).grep(*.so)
    {
        .elems == 2 and
        .sum   == 0 
    }
}
