#!/usr/bin/env perl
use v5.40;

sub stringReduction($word) {
  while ($word =~ s/(.)\1//g) { }
  $word
}

sub solution($word) {
  say "Input: \$word = \"$word\"";
  say "Output: \"@{[stringReduction($word)]}\"";
}

say "Example 1:";
solution("aabbccdd");

say "\nExample 2:";
solution("abccba");

say "\nExample 3:";
solution("abcdef");

say "\nExample 4:";
solution("aabbaeaccdd");

say "\nExample 5:";
solution("mississippi");
