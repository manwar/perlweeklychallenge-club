#!/usr/bin/env raku
use v6;

sub strVal($str) {
  return $str.Int unless $str ~~ /\D/;
  return $str.chars;
}

sub maxStrVal(@strings) {
  return max @strings.map({ strVal($_) });
}

sub solution(@strings) {
  say 'Input: @strings = ('
    ~ @strings.map({qq{"$_"}}).join(', ')~ ')';
  say 'Output: ' ~ maxStrVal(@strings);
}

say "Example 1:";
solution(["123", "45", "6"]);

say "\nExample 2:";
solution(["abc", "de", "fghi"]);

say "\nExample 3:";
solution(["0012", "99", "a1b2c"]);

say "\nExample 4:";
solution(["x", "10", "xyz", "007"]);

say "\nExample 5:";
solution(["hello123", "2026", "perl"]);
