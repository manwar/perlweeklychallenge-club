#!/usr/bin/env perl
use v5.40;

sub reverseExistence($str) {
  my $trs = reverse $str;
  foreach my $i ( 0..length($str)-2 ) {
    my $substr = substr($str, $i, 2);
    return 'true' if index($trs, $substr) >= 0;
  }
  return 'false';
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say 'Output: ' . reverseExistence($str);
}

say "Example 1:";
solution("abcba");

say "\nExample 2:";
solution("racecar");

say "\nExample 3:";
solution("abcd");

say "\nExample 4:";
solution("banana");

say "\nExample 5:";
solution("hello");