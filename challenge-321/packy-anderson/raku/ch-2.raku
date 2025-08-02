#!/usr/bin/env raku
use v6;

sub backspaceCompare($str1, $str2) {
  # if we pass in these as 'is rw', it expects to be passed
  # a writable container, which a string literal is not.
  # it's just easier to copy it to a writable container.
  my $s1 = $str1; while ($s1 ~~ s/.\#//) {}
  my $s2 = $str2; while ($s2 ~~ s/.\#//) {}
  return $s1 eq $s2;
}

sub solution($str1, $str2) {
  say qq{Input: \$str1 = "$str1"};
  say qq{       \$str2 = "$str2"};
  say 'Output: ' ~ backspaceCompare($str1, $str2);
}

say "Example 1:";
solution("ab#c", "ad#c");

say "\nExample 2:";
solution("ab##", "a#b#");

say "\nExample 3:";
solution("a#b", "c");
