#!/usr/bin/env raku
use v6;

sub my_reverse($str) {
  my $rts = "";
  for $str.comb -> $char {
    $rts = $char ~ $rts;
  }
  $rts;
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  say 'Output: "' ~ my_reverse($str) ~ '"';
}

say "Example 1:";
solution("");

say "\nExample 2:";
solution("reverse the given string");

say "\nExample 3:";
solution("Perl is Awesome");

say "\nExample 4:";
solution("v1.0.0-Beta!");

say "\nExample 5:";
solution("racecar");
