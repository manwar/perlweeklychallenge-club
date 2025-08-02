#!/usr/bin/env raku
use Test;

ok  friendly-strings("desc",   "dsec");
ok  friendly-strings("fuck",   "fcuk");
nok friendly-strings("poo",    "eop");
ok  friendly-strings("stripe", "sprite");
ok  friendly-strings("none",   "none");    
nok friendly-strings("zero",   "zero");
nok friendly-strings("four",   "ofru");
nok friendly-strings("stripe", "surioe");
nok friendly-strings("stripe", "spripe");

sub friendly-strings($str1, $str2)
{
    my @str1 = $str1.comb;
    my @str2 = $str2.comb;

    given (@str1 Zne @str2).grep(*.so, :k)
    {
        when    .elems == 0 { $str1 ~~ / (<alpha>) .* $0 /  } 
        when    .elems == 2 { @str1[$_] eqv @str2[.reverse] }
        default             { False                         }
    }
}
