#!/usr/bin/env raku
use Test;

ok  reverse-existence("abcba");
ok  reverse-existence("racecar");
nok reverse-existence("abcd");
ok  reverse-existence("banana");
ok  reverse-existence("hello");

sub reverse-existence($str)
{
    ($str.flip ~~ m:ov/../).first({ $str.contains($_) })
}
