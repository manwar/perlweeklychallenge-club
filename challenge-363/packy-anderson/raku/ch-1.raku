#!/usr/bin/env raku
use v6;

use Lingua::NumericWordForms;

my $extract_regex = rx/
  $<string> = [ \w+ ] \s+ <[\-\—\―]> \s+
  $<vowels> = [ .+ ] \s+ vowels?
  \s+ and \s+
  $<consonants> = [ .+ ] \s+ consonants?
/;

sub lieDetector($str) {
  $str ~~ $extract_regex;
  my $vowel_count     = ~$<string>.comb(/<[aeiou]>/).elems;
  my $consonant_count = ~$<string>.comb(/<-[aeiou]>/).elems;
  my $vowel_claim     = from-numeric-word-form(~$<vowels>);
  my $consonant_claim = from-numeric-word-form(~$<consonants>);
  return $vowel_count     == $vowel_claim
      && $consonant_count == $consonant_claim;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: {lieDetector($str)}/;
}

say "Example 1:";
solution("aa — two vowels and zero consonants");

say "\nExample 2:";
solution("iv — one vowel and one consonant");

say "\nExample 3:";
solution("hello - three vowels and two consonants");

say "\nExample 4:";
solution("aeiou — five vowels and zero consonants");

say "\nExample 5:";
solution("aei — three vowels and zero consonants");
