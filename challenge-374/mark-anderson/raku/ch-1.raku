#!/usr/bin/env raku
use Test;

is-deeply count-vowel("aeiou"),         ("aeiou",);
is-deeply count-vowel("aaeeeiioouu"),   <aaeeeiioouu aaeeeiioou aeeeiioouu aeeeiioou>;
is-deeply count-vowel("aeiouuaxaeiou"), <aeiouua aeiouu aeiou eiouua aeiou>;
is-deeply count-vowel("uaeiou"),        <uaeiou uaeio aeiou>;
is-deeply count-vowel("aeioaeioa"),     ();

sub count-vowel($str)
{
    ($str ~~ m:ex/(<[aeiou]> ** 5..*) <?{ $0.comb (==) <a e i o u> }>/)>>[0]>>.Str
}
