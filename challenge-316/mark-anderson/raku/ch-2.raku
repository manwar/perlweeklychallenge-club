#!/usr/bin/env raku
use Test;

ok  subsequence("uvw", "bcudvew");
nok subsequence("aec", "abcde");
ok  subsequence("sip", "javascript");

sub subsequence($str1, $str2)
{
    $str2 ~~ / <{ $str1.comb.join(".*") }> /
}
