#!/usr/bin/env perl
use v5.40;

sub groupDivision($str, $size, $filler) {
  $str .= $filler while length($str) % $size;
  my $count = length($str) / $size;
  my $template = "a$size" x $count;
  unpack $template, $str;
}

sub solution($str, $size, $filler) {
  say qq/Input: \$str = "$str", \$size = $size, \$filler = "$filler"/;
  my $results = join ", ", map { qq/"$_"/ } groupDivision($str, $size, $filler);
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
