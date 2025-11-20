#!/usr/bin/env raku
use v6;

sub countVowels($str) {
  my @vowels = $str.lc.comb(/<[aeiou]>/);
  my $count  = @vowels.elems;
  my $vowel  = 'vowel' ~ ($count == 1 ?? '' !! 's');
  return ($count, $vowel);
}

sub stringAlike($str) {
  my $explain;
  # split the string
  my $halfLen = $str.chars / 2;
  my $first   = $str.substr(0..($halfLen-1));
  my $second  = $str.substr($halfLen);
  # count the vowels
  my ($count1, $vowel1) = countVowels($first);
  $explain = qq{1st half: "$first" ($count1 $vowel1)\n};
  my ($count2, $vowel2) = countVowels($second);
  $explain ~= qq{2nd half: "$second" ($count2 $vowel2)};
  # return the result
  my $bool = $count1 == $count2 && $count1 > 0;
  return "$bool\n\n$explain";
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: {stringAlike($str)}/;
}

say "Example 1:";
solution("textbook");

say "\nExample 2:";
solution("book");

say "\nExample 3:";
solution("AbCdEfGh");

say "\nExample 4:";
solution("rhythmmyth");

say "\nExample 5:";
solution("UmpireeAudio");
