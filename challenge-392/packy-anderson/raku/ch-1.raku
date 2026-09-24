#!/usr/bin/env raku
use v6;

sub isPalindrome($str) {
  return True if $str.chars <= 1;
  return $str.substr(0,1) eq $str.substr(*-1)
      && isPalindrome($str.substr(1,*-1));
}

sub convertPalindrome($str is copy) {
  my $add = "";
  while (! isPalindrome($str)) {
    $add ~= $str.substr(*-1);
    $str.substr-rw(*-1) = "";
  }
  return $add ~ $str ~ $add.flip;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "{convertPalindrome($str)}"/;
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
