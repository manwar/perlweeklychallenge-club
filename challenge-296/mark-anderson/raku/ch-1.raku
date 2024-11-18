#!/usr/bin/env raku
use Test;

is string-compression("abbc"),                      "a2bc";
is string-compression("aaabccc"),                   "3ab3c";
is string-compression("abcc"),                      "ab2c";
is string-compression("baaaabbcaaaaaaaaaaaaaaccc"), "b4a2bc14a3c";

is string-decompression("a2bc"),        "abbc";
is string-decompression("3ab3c"),       "aaabccc";
is string-decompression("ab2c"),        "abcc";
is string-decompression("b4a2bc14a3c"), "baaaabbcaaaaaaaaaaaaaaccc";

sub string-compression($chars)
{
    [~] do for $chars ~~ m:g/(<.alpha>)$0*/
    {
        my $chars = .pos - .from;
        $chars == 1 ?? .[0] !! $chars ~ .[0]           
    }
}

sub string-decompression($chars is copy)
{
    $chars ~~ s/^(<.alpha>)/1{$0}/;
    $chars ~~ s:g/(<.alpha>)(<.alpha>)/{$0}1{$1}/;
    my $seq = $chars.split(/<.alpha>/, :v:skip-empty);
    [~] do .value x .key for $seq.pairup
}
