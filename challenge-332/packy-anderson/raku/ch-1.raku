#!/usr/bin/env raku
use v6;

sub binaryDate($date) {
  $date.split(/\-/).map({ .Int.base(2) }).join("-");
}

sub solution($date) {
  say qq/Input: \$date = "$date"/;
  say qq/Output: "{binaryDate($date)}"/;
}

say "Example 1:";
solution("2025-07-26");

say "\nExample 2:";
solution("2000-02-02");

say "\nExample 3:";
solution("2024-12-31");
