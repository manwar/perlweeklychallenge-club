#!/usr/bin/env raku
use Test;

is group-position("abccccd"), ("cccc");
is group-position("aaabcddddeefff"), ("aaa", "dddd", "fff");
is group-position("abcdd"), ("");

sub group-position($str)
{
    $str ~~ m:g/ (\w) $0 ** 2..* /
}
