#!/usr/bin/env perl
use v5.40;

sub echo($string) {
  my $i = 1;
  my $result;
  foreach my $c (split //, $string) {
    $result .= $c x $i++;
  }
  return $result;
}

sub solution($string) {
  say qq/Input: "$string"/;
  say qq/Output: "@{[echo($string)]}"/;
}

say "Example 1:";
solution("abca");

say "\nExample 2:";
solution("xyz");

say "\nExample 3:";
solution("code");

say "\nExample 4:";
solution("hello");

say "\nExample 5:";
solution("a");
