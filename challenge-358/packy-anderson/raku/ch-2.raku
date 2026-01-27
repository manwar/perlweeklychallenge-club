#!/usr/bin/env raku
use v6;

sub rotN($str, $n is copy) {
  $n = $n % 26; # 0 <= n < 26
  my $orig = ('a'..'z').join;
  my $shifted = $orig.substr($n..26) ~ $orig.substr(0..$n-1);
  return $str.trans($orig => $shifted);
}

sub solution($str, $int) {
  say qq/Input: \$str = "$str", \$int = $int/;
  say qq/Output: "{rotN($str, $int)}"/;
}

say "Example 1:";
solution("abc", 1);

say "\nExample 2:";
solution("xyz", 2);

say "\nExample 3:";
solution("abc", 27);

say "\nExample 4:";
solution("hello", 5);

say "\nExample 5:";
solution("perl", 26);
