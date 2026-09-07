#!/usr/bin/env raku
use Test;

is order-characters("dbca",     1), "adbc";
is order-characters("geeks",    2), "eegks";
is order-characters("cbaed",    3), "abcde";
is order-characters("fedcba",   4), "abcdef";
is order-characters("perl",     1), "erlp";
is order-characters("oloolooo", 1), "looloooo";
is order-characters("oloooolo", 1), "looloooo";

# https://medium.com/@simontoth/daily-bit-e-of-c-lexicographically-minimum-string-1ff232db1612

multi order-characters($str, $k where * >= 2)
{
    $str.comb.sort.join
}

multi order-characters($str, $k)
{
    my @str = $str.comb;
    
    return .min.join given do for @str.min(:k) 
    {
        @str.rotate($_)        
    }
}
