#!/usr/bin/env raku
use Test;

is-deeply count-vowel("aeiou"),         ("aeiou",);
is-deeply count-vowel("aaeeeiioouu"),   <aaeeeiioouu aaeeeiioou aeeeiioouu aeeeiioou>;
is-deeply count-vowel("aeiouuaxaeiou"), <aeiouua aeiouu aeiou eiouua aeiou>;
is-deeply count-vowel("uaeiou"),        <uaeiou uaeio aeiou>;
is-deeply count-vowel("aeioaeioa"),     ();

is-deeply count-vowel-v2("aeiou"),         ("aeiou",);
is-deeply count-vowel-v2("aaeeeiioouu"),   <aaeeeiioouu aaeeeiioou aeeeiioouu aeeeiioou>;
is-deeply count-vowel-v2("aeiouuaxaeiou"), <aeiouua aeiouu aeiou eiouua aeiou>;
is-deeply count-vowel-v2("uaeiou"),        <uaeiou uaeio aeiou>;
is-deeply count-vowel-v2("aeioaeioa"),     ();

is-deeply count-vowel-v3("aeiou"),         ("aeiou",);
is-deeply count-vowel-v3("aaeeeiioouu"),   <aaeeeiioouu aaeeeiioou aeeeiioouu aeeeiioou>;
is-deeply count-vowel-v3("aeiouuaxaeiou"), <aeiouua aeiouu aeiou eiouua aeiou>;
is-deeply count-vowel-v3("uaeiou"),        <uaeiou uaeio aeiou>;
is-deeply count-vowel-v3("aeioaeioa"),     ();

sub count-vowel($str)
{
    ($str ~~ m:ex/(<[aeiou]> ** 5..*) <?{ $0.comb (==) <a e i o u> }>/)>>[0]>>.Str
}

sub count-vowel-v2($str)
{
    flat $str.comb(/<[aeiou]>+/).map: { (m:ex/.*a.* & .*e.* & .*i.* & .*o.* & .*u.*/).words.unique }
}

# I like this version but it doesn't catch the second aeiou in example 3
sub count-vowel-v3($str)
{
    ($str ~~ m:ex/.*a.* & .*e.* & .*i.* & .*o.* & .*u.* & <-[bcdfghjklmnpqrstvwxyz]>*/).words.unique
}
