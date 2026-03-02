#!/usr/bin/env raku
use v6;

multi echo($i, @chars) {
  return "" unless @chars;
  @chars[0] x $i ~ echo($i+1, @chars[1 .. *-1]);
}

multi echo($string) { echo(1, $string.comb); }

sub solution($string) {
  say qq/Input: "$string"/;
  say qq/Output: "{echo($string)}"/;
}

say "Example 1:";
solution("abca");

say "\nExample 2:";
solution("xyz");

say "\nExample 3:";
solution("code");

say "\nExample 4:";
solution("hello");

say "\nExample 5:";
solution("a");
