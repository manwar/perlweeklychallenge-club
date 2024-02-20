#!/usr/bin/env raku
use v6;

sub mergeStrings($str1, $str2) {
  my @chars1 = $str1.split('', :skip-empty);
  my @chars2 = $str2.split('', :skip-empty);
  my $result;
  while (@chars1 || @chars2) {
    $result ~= @chars1.shift if @chars1;
    $result ~= @chars2.shift if @chars2;
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