#!/usr/bin/env perl
use v5.40;

sub reversePrefix($str, $char) {
  my $loc = index($str, $char) + 1;
  reverse(substr($str, 0, $loc)) . substr($str, $loc);
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
