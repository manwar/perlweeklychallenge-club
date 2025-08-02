#!/usr/bin/env perl
use v5.40;

sub splitString($str) {
  return (
    ( grep { /[aeiou]/i } split //, $str ) % 2 == 0
    ? 'True' : 'False'
  );
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: ' . splitString($str);
}

say "Example 1:";
solution("perl");

say "\nExample 2:";
solution("book");

say "\nExample 3:";
solution("good morning");
