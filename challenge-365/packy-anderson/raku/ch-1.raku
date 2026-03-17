#!/usr/bin/env raku
use v6;

sub alphaIndexDigitSum($str, $k is copy) {
  my $numstr = $str.comb.map({ ord($_) - 96 }).join;
  $numstr = $numstr.comb.sum.Str while ($k-- > 0);
  return $numstr;
}

sub solution($str, $k) {
  say qq/Input: \$str = "$str", \$k = $k/;
  say qq/Output: {alphaIndexDigitSum($str, $k)}/;
}

say "Example 1:";
solution("abc", 1);

say "\nExample 2:";
solution("az", 2);

say "\nExample 3:";
solution("cat", 1);

say "\nExample 4:";
solution("dog", 2);

say "\nExample 5:";
solution("perl", 3);

say "\nExample BigBird:";
solution("abcdefghijklmnopqrstuvwxyz", 1);
