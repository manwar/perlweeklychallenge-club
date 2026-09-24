#!/usr/bin/env perl
use v5.44;

sub isPalindrome($str) {
  return true if length($str) <= 1;
  return substr($str,0,1) eq substr($str,-1)
      && isPalindrome(substr($str,1,-1));
}

sub convertPalindrome($str) {
  my $add = "";
  while (! isPalindrome($str)) {
    $add .= substr($str,-1);
    substr($str,-1) = "";
  }
  return $add . $str . reverse($add);
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "@{[convertPalindrome($str)]}"/;
}

say "Example 1:";
solution("pinnipeds");

say "\nExample 2:";
solution("abcd");

say "\nExample 3:";
solution("bananas");

say "\nExample 4:";
solution("dissident");

say "\nExample 5:";
solution("cailliachs");

say "\nExample 6:";
solution("gohangasalamiimalasagnahog");
