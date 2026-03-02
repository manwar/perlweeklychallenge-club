#!/usr/bin/env raku
use Lingua::EN::Numbers;
use Test;

ok  string-lie-detector('aa - two vowels and zero consonants');
ok  string-lie-detector('iv - one vowel and one consonant');
nok string-lie-detector('hello - three vowels and two consonants');
ok  string-lie-detector('aeiou - five vowels and zero consonants');
ok  string-lie-detector('aei - three vowels and zero consonants');

sub string-lie-detector($str)
{
    given $str ~~ m:s/^ (.+?) '-' (.+?) vowels? and (.+?) consonants? $/ -> ($s,$v,$c)
    {
        my $vowels = ($s ~~ m:g/<[aeiou]>/).elems;
        my $consonants = $s.chars - $vowels;
        all $v eq cardinal($vowels), $c eq cardinal($consonants)
    }
}
