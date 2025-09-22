#!/usr/bin/env raku
use Test;

is dup-rm("abbaca"),   "ca";
is dup-rm("azxxzy"),   "ay";
is dup-rm("aaaaaaaa"), Empty.Str;
is dup-rm("aabccba"),  "a";
is dup-rm("abcddcba"), Empty.Str;

sub dup-rm($str is copy)
{
    my $c;

    while $str ~~ s:r:c($c)/ (<lower>) $0+ //
    {
        $c = max 0, $/.from - 1
    }

    return $str
}
