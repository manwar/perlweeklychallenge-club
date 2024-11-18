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
    [~] do for $chars ~~ m:g/(<.alpha>)$0*/
    {
        my $chars = .pos - .from;
        $chars == 1 ?? .[0] !! $chars ~ .[0]           
    }
}

sub decompress($chars)
{
    [~] gather $chars ~~ m:g/(<.digit>+)?(<.alpha>) { take $0 ?? $1 x $0 !! $1 }/ 
}
