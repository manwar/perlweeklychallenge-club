#!/usr/bin/env raku
use v6;

sub oddLetters($str) {
  for $str.comb.Bag.values -> $times {
    return 'false' if $times % 2 == 0;
  }
  return 'true';
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: {oddLetters($str)}/;
}

say "Example 1:";
solution("weekly");

say "\nExample 2:";
solution("perl");

say "\nExample 3:";
solution("challenge");
