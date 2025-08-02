#!/usr/bin/env raku
use v6;

sub defang($ip) {
  $ip ~~ / (\d+) '.' (\d+) '.' (\d+) '.' (\d+) /;
  return @$/.join('[.]');
}

sub solution($ip) {
  say 'Input: $ip = "' ~ $ip ~ '"';
  say 'Output: "' ~ defang($ip) ~ '"';
}

say "Example 1:";
solution("1.1.1.1");

say "\nExample 2:";
solution("255.101.1.0");
