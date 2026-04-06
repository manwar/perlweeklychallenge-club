#!/usr/bin/env raku
use v6;

sub maxOddBinary($str) {
  my @bits = $str.comb.sort.reverse;
  @bits.push(@bits.shift).join;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "{maxOddBinary($str)}"/;
}

say "Example 1:";
solution("1011");

say "\nExample 2:";
solution("100");

say "\nExample 3:";
solution("111000");

say "\nExample 4:";
solution("0101");

say "\nExample 5:";
solution("1111");
