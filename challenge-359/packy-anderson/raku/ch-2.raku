#!/usr/bin/env raku
use v6;

sub stringReduction($word is copy) {
  while ($word ~~ s:g/(.)$0//) { }
  $word
}

sub solution($word) {
  say "Input: \$word = \"$word\"";
  say "Output: \"{stringReduction($word)}\"";
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
