#!/usr/bin/env raku
use v6;

sub lastWord($str) {
  return $str.split(q{ }, :skip-empty)[*-1].chars;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: {lastWord($str)}/;
}

say "Example 1:";
solution("The Weekly Challenge");

say "\nExample 2:";
solution("   Hello   World    ");

say "\nExample 3:";
solution("Let's begin the fun");
