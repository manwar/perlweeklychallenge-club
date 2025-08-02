#!/usr/bin/env perl
use v5.38;

sub mergeStrings($str1, $str2) {
  my @chars1 = split(//, $str1);
  my @chars2 = split(//, $str2);
  my $result;
  while (@chars1 || @chars2) {
    $result .= shift(@chars1) if @chars1;
    $result .= shift(@chars2) if @chars2;
  }
  return $result;
}

sub solution($str1, $str2) {
  say qq{Input: \$str1 = "$str1", \$str2 = "$str2"};
  my $output = mergeStrings($str1, $str2);
  say qq{Output: "$output"};
}

say "Example 1:";
solution("abcd", "1234");

say "\nExample 2:";
solution("abc", "12345");