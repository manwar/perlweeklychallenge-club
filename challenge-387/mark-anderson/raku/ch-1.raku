#!/usr/bin/env raku
use Test;

is rbs("111000"), 0;
is rbs("00011"),  4;
is rbs("01011"),  3;
is rbs("010101"), 3;
is rbs("00001"),  4;

sub rbs($str is copy)
{
    .elems given gather take ~$/ while $str ~~ s:g/01/10/
}
