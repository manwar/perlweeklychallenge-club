#!/usr/bin/env raku
use Test;

is sld("aaaaa77777"),         -1;
is sld("abcde"),              -1;
is sld("9zero8eight7seven9"),  8;
is sld("xyz9876543210"),       8;
is sld("4abc4def2ghi8jkl2"),   4;

sub sld($str)
{
    $str.comb(/<.digit>/).unique.sort[*-2] // -1
}
