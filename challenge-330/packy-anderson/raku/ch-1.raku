#!/usr/bin/env raku
use v6;

sub clearDigits($str is copy) {
  while ($str ~~ s/\D\d//) {}
  return $str;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "{clearDigits($str)}"/;
}

say "Example 1:";
solution("cab12");

say "\nExample 2:";
solution("xy99");

say "\nExample 3:";
solution("pa1erl");
