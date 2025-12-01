#!/usr/bin/env raku
use Test;

is good-substrings("abcaefg"), 5;
is good-substrings("xyzzabc"), 3;
is good-substrings("aababc"),  1;
is good-substrings("qwerty"),  4;
is good-substrings("zzzaaa"),  0;

sub good-substrings($str)
{
    .elems given $str ~~ m:ov/(.)(.)(.) <?{ [ne] $0,$1,$2,$0 }>/
}
