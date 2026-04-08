#!/usr/bin/env raku
use v6;

sub bigger($str, $char) {
  my @indices = $str.indices($char);
  return $str unless @indices; # doesn't occur
  my @possible;
  for @indices -> $i {
    (my $tmp = $str).substr-rw($i, 1) = "";
    @possible.push($tmp);
  }
  return @possible.max;
}

sub solution($str, $char) {
  say qq/Input: \$str = "$str", \$char = "$char"/;
  say qq/Output: "{bigger($str, $char)}"/;
}

say "Example 1:";
solution("15456", "5");

say "\nExample 2:";
solution("7332", "3");

say "\nExample 3:";
solution("2231", "2");

say "\nExample 4:";
solution("543251", "5");

say "\nExample 5:";
solution("1921", "1");

say "\nExample trivial 1:";
solution("12345", "6");

say "\nExample trivial 2:";
solution("12345", "1");
