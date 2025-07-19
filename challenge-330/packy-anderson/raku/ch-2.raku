#!/usr/bin/env raku
use v6;

sub titleCapital($str) {
  my @out = $str.lc.split(" "); # separated by a SINGLE space
  for @out <-> $word { # <-> makes mods to $word change @out
    $word = $word.tc if $word.chars > 2;
  }
  return @out.join(" ");
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "{titleCapital($str)}"/;
}

say "Example 1:";
solution("PERL IS gREAT");

say "\nExample 2:";
solution("THE weekly challenge");

say "\nExample 3:";
solution("YoU ARE A stAR");
