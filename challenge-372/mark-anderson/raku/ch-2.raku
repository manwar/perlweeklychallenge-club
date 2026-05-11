#!/usr/bin/env raku
use Test;

is largest-substring("aaaaa"),    3;
is largest-substring("abcdeba"),  5;
is largest-substring("abbc"),     0;
is largest-substring("abcaacbc"), 4;
is largest-substring("laptop"),   2;

sub largest-substring($str)
{
    my @m = $str ~~ m:ov/ (.) (.*) (.) <?{ $0 eq $2 }> /;
    @m>>[1].max(*.chars).chars 
}
