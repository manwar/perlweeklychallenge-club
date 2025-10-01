#!/usr/bin/env raku
use v6;

sub reversePrefix($str, $char) {
  my $loc = $str.index($char) + 1;
  $str.substr(0, $loc).flip ~ $str.substr($loc);
}

sub solution($str, $char) {
  say qq{Input: \$str = "$str", \$char = "$char"};
  my $result = reversePrefix($str, $char);
  say qq{Output: "$result"};
}

say "Example 1:";
solution("programming", "g");

say "\nExample 2:";
solution("hello", "h");

say "\nExample 3:";
solution("abcdefghij", "h");

say "\nExample 4:";
solution("reverse", "s");

say "\nExample 5:";
solution("perl","r");
