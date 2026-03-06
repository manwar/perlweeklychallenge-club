#!/usr/bin/env perl
use v5.40;

use Lingua::EN::Words2Nums;

my $extract_regex = qr/
  (?<string> \w+ ) \s+ [\-\—\―]+ \s+
  (?<vowels> .+  ) \s+ vowels?
  \s+ and \s+
  (?<consonants> .+ ) \s+ consonants?
/x;

sub comb($str, $regex) {
  map { /$regex/ } split //, $str;
}

sub lieDetector($str) {
  $str =~ /$extract_regex/;
  my $vowel_count     = scalar(comb($+{string}, qr/[aeiou]/));
  my $consonant_count = scalar(comb($+{string}, qr/[^aeiou]/));
  my $vowel_claim     = words2nums($+{vowels});
  my $consonant_claim = words2nums($+{consonants});
  return $vowel_count     == $vowel_claim
      && $consonant_count == $consonant_claim;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: @{[lieDetector($str) ? 'true' : 'false']}/;
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
