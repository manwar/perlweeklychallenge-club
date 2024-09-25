#!/usr/bin/env raku
use v6;

grammar IsNumber {
  rule TOP { [
    <integerNumber><exponent>? | <decimalNumber><exponent>?
  ] }

  token sign { <[ + \- ]> }

  token digits { \d+ }

  token integerNumber { <sign>? <digits> }

  token decimalNumber {
    <sign>? [ <digits> '.' | <digits> '.' <digits> | '.' <digits> ]
  }

  token exponent { [ "e" | "E" ] <integerNumber> }
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: ' ~ (IsNumber.parse($str) ?? True !! False);
}

say "Example 1:";
solution("1");

say "\nExample 2:";
solution("a");

say "\nExample 3:";
solution(".");

say "\nExample 4:";
solution("1.2e4.2");

say "\nExample 5:";
solution("-1.");

say "\nExample 6:";
solution("+1E-8");

say "\nExample 7:";
solution(".44");

say "\nExample 8:";
solution("-३.१")