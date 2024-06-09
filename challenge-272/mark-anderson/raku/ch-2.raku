#!/usr/bin/env raku
use Test;

is string-score("hello"), 13;
is string-score("perl"),  30;
is string-score("raku"),  37;

sub string-score($str)
{
    [+] map { abs(.[0].ord - .[1].ord) }, $str.comb.rotor(2 => -1) 
}
