#!/usr/bin/env raku
use v6;

sub charPercent($str, $char) {
  return round(( $str.comb($char).elems / $str.chars ) * 100);
}

sub solution($str, $char) {
  say qq{Input: \$str = "$str", \$char = "$char"};
  say 'Output: ' ~ charPercent($str, $char);
}

say "Example 1:";
solution("perl", "e");

say "\nExample 2:";
solution("java", "a");

say "\nExample 3:";
solution("python", "m");

say "\nExample 4:";
solution("ada", "a");

say "\nExample 5:";
solution("ballerina", "l");

say "\nExample 6:";
solution("analitik", "k");
