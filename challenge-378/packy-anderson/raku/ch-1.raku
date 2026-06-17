#!/usr/bin/env raku
use v6;

sub secondLargestDigit($str) {
  my ($one, $two) = (-1, -1);
  for $str.comb(/\d/) -> $digit { # this gives us only digits
    if ($digit > $one) {
      ($one, $two) = ($digit, $one);
    }
    elsif ($digit < $one && $digit > $two) {
      $two = $digit;
    }
  }
  $two;
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  say 'Output: ' ~ secondLargestDigit($str);
}

say "Example 1:";
solution("aaaaa77777");

say "\nExample 2:";
solution("abcde");

say "\nExample 3:";
solution("9zero8eight7seven9");

say "\nExample 4:";
solution("xyz9876543210");

say "\nExample 5:";
solution("4abc4def2ghi8jkl2");
