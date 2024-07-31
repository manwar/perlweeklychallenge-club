#!/usr/bin/env raku
use Test;

is count-asterisks("p|*e*rl|w**e|*ekly|"),           2;
is count-asterisks("perl"),                          0;
is count-asterisks("th|ewe|e**|k|l***ych|alleng|e"), 5;
is count-asterisks("|p|*e*rl|w**e|*ekly|"),          3;

sub count-asterisks($str)
{
    $str.split("|")[0,2...*].comb("*").elems
}
