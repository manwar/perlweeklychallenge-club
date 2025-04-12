#!/usr/bin/env raku
use v6;

sub subsequence($str1, $str2) {
  # start at the beginning of both strings
  my ($p1, $p2) = (0, 0);
  while ($p2 < $str2.chars) {
    # if the current character of the first string matches
    # the current character of the second string...
    if (substr($str1, $p1, 1) eq substr($str2, $p2, 1)) {
      # move to the next character in the first string
      $p1++;
    }
    # if we've run off the end of the first string,
    # we wound up finding all the characters!
    return True if $p1 == $str1.chars;

    # move to the next character of the second string
    $p2++;
  }
  # if we've run off the end of the second string,
  # this character isn't in the second string
  return False;
}

sub solution($str1, $str2) {
  say qq{Input: \$str1 = "$str1", \$str2 = "$str2"};
  say 'Output: ' ~ subsequence($str1, $str2);
}

say "Example 1:";
solution("uvw", "bcudvew");

say "\nExample 2:";
solution("aec", "abcde");

say "\nExample 3:";
solution("sip", "javascript");
