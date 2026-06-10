#!/usr/bin/env raku
use v6.e.PREVIEW; # so I can use .comb with a rotor pair

sub reverseExistence($str) {
  my $trs = $str.flip;
  for $str.comb(2 => -1) -> $substr {
    return 'true' if $trs.index($substr).defined;
  }
  return 'false';
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say 'Output: ' ~ reverseExistence($str);
}

say "Example 1:";
solution("abcba");

say "\nExample 2:";
solution("racecar");

say "\nExample 3:";
solution("abcd");

say "\nExample 4:";
solution("banana");

say "\nExample 5:";
solution("hello");
