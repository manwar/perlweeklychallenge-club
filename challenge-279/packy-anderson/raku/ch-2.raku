#!/usr/bin/env raku
use v6;

sub splitString($str) {
  return $str.lc.comb(/<[aeiou]>/).elems % 2 == 0;
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: ' ~ splitString($str);
}

say "Example 1:";
solution("perl");

say "\nExample 2:";
solution("book");

say "\nExample 3:";
solution("good morning");
