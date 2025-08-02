#!/usr/bin/env raku
use Test;

is merge-strings("abcd",  "1234"),  "a1b2c3d4";
is merge-strings("abc",   "12345"), "a1b2c345";
is merge-strings("abcde", "123"),   "a1b2c3de";

sub merge-strings($s1, $s2)
{
    [~] flat roundrobin $s1.comb, $s2.comb
}
