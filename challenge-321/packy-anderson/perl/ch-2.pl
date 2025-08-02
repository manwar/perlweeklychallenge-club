#!/usr/bin/env perl
use v5.40;

sub backspaceCompare($str1, $str2) {
  while ($str1 =~ s/.\#//) {}
  while ($str2 =~ s/.\#//) {}
  return $str1 eq $str2 ? 'true' : 'false';
}

sub solution($str1, $str2) {
  say qq{Input: \$str1 = "$str1"};
  say qq{       \$str2 = "$str2"};
  say 'Output: ' . backspaceCompare($str1, $str2);
}

say "Example 1:";
solution("ab#c", "ad#c");

say "\nExample 2:";
solution("ab##", "a#b#");

say "\nExample 3:";
solution("a#b", "c");
