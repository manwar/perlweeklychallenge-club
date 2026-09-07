#!/usr/bin/env raku
use Test;

is decode-string("2[3[a]]"),      "aaaaaa";
is decode-string("10[a]"),        "aaaaaaaaaa";
is decode-string("a2[b]c3[d]e"),  "abbcddde";
is decode-string("2[a2[b]c]"),    "abbcabbc";
is decode-string("1[a]2[b3[c]]"), "abcccbccc";

sub decode-string($str is copy)
{
    loop
    {
        $str ~~ s:g/(\d+) '[' (<-[\[\]]>*) ']'/{ $1 x $0 }/;
        last unless $/
    }

    $str
}
