#!/usr/bin/env raku
use v6;

sub groupDivision($str is copy, $size, $filler) {
  $str ~= $filler while $str.chars % $size;
  $str.comb($size)
}

sub solution($str, $size, $filler) {
  say qq/Input: \$str = "$str", \$size = $size, \$filler = "$filler"/;
  my $results = groupDivision($str, $size, $filler).map({ qq/"$_"/ }).join(", ");
  say qq/Output: ($results)/;
}

say "Example 1:";
solution("RakuPerl", 4, "*");

say "\nExample 2:";
solution("Python", 5, "0");

say "\nExample 3:";
solution("12345", 3, "x");

say "\nExample 4:";
solution("HelloWorld", 3, "_");

say "\nExample 5:";
solution("AI", 5, "!");
