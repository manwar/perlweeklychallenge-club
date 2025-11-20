#!/usr/bin/env perl
use v5.40;

sub countVowels($str) {
  (my $vowels = $str)  =~ s/[^aeiou]//ig;
  my $count   = length($vowels);
  my $vowel   = 'vowel' . ($count == 1 ? '' : 's');
  return ($count, $vowel);
}

sub stringAlike($str) {
  my $explain;
  # split the string
  my $halfLen = length($str) / 2;
  my $first   = substr($str, 0, $halfLen);
  my $second  = substr($str, $halfLen);
  # count the vowels
  my ($count1, $vowel1) = countVowels($first);
  $explain = qq{1st half: "$first" ($count1 $vowel1)\n};
  my ($count2, $vowel2) = countVowels($second);
  $explain .= qq{2nd half: "$second" ($count2 $vowel2)};
  # return the result
  my $bool = $count1 == $count2 && $count1 > 0 ? 'True' : 'False';
  return "$bool\n\n$explain";
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: @{[stringAlike($str)]}/;
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
