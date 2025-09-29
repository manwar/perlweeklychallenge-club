#!/usr/bin/env perl
use v5.40;

sub duplicateRemoval($str) {
  return $str
    unless $str =~ s/([a-z])\g1//;
  duplicateRemoval($str);
}

sub solution($str) {
  say "Input: \$str = '$str'";
  say "Output: '@{[duplicateRemoval($str)]}'";
}

say "Example 1:";
solution("abbaca");

say "\nExample 2:";
solution("azxxzy");

say "\nExample 3:";
solution("aaaaaaaa");

say "\nExample 4:";
solution("aabccba");

say "\nExample 5:";
solution("abcddcba");
