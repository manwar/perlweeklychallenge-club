#!/usr/bin/env raku
use Test;

is max-odd-binary("1011"),   "1101";
is max-odd-binary("100"),    "001";
is max-odd-binary("111000"), "110001";
is max-odd-binary("0101"),   "1001";
is max-odd-binary("1111"),   "1111";

sub max-odd-binary($str)
{
    $str.comb.sort(-*).rotate.join
}
