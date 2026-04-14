#!/usr/bin/env raku
use Test;

is group-division("RakuPerl", 4, "*"),   <Raku Perl>;
is group-division("Python", 5, "0"),     <Pytho n0000>;
is group-division("12345", 3, "x"),      <123 45x>;
is group-division("HelloWorld", 3, "_"), <Hel loW orl d__>;
is group-division("AI", 5, "!"),         <AI!!!>;

sub group-division($str, $size, $filler)
{
    given $str.comb($size).Array
    {
        .tail ~= $filler x $size - .tail.chars;
        .return
    }
}
