#!/usr/bin/env raku
use Test;

is compress("abbc"),                      "a2bc";
is compress("aaabccc"),                   "3ab3c";
is compress("abcc"),                      "ab2c";
is compress("baaaabbcaaaaaaaaaaaaaaccc"), "b4a2bc14a3c";

is decompress("a2bc"),                    "abbc";
is decompress("3ab3c"),                   "aaabccc";
is decompress("ab2c"),                    "abcc";
is decompress("b4a2bc14a3c"),             "baaaabbcaaaaaaaaaaaaaaccc";

sub compress($chars)
{
    S:g/(<.alpha>) $0 ** 1..*/{$/.pos - $/.from}$0/ given $chars
}

sub decompress($chars)
{
    S:g/(<.digit>+) (<.alpha>)/{$1 x $0}/ given $chars
}
