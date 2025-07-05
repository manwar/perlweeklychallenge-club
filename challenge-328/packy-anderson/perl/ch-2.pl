#!/usr/bin/env perl
use v5.40;

sub goodString($str) {
  # return the unmodified string if there are no matches
  return $str
    unless $str =~ /(?<match> (\p{Ll}) (??{ uc($^N) }) |
                              (\p{Lu}) (??{ lc($^N) }) )/x;

  # replace the match with the empty string
  my $replace = $+{match};
  # when I try to use $<match> in the replacement, it doesn't work
  $str =~ s/$replace//;

  # recursively call to eliminate additional pairs
  goodString($str);
}

sub solution($str) {
  say "Input: \$str = \"$str\"";
  say "Output: \"@{[goodString($str)]}\"";
}

say "Example 1:";
solution("WeEeekly");

say "\nExample 2:";
solution("abBAdD");

say "\nExample 3:";
solution("abc");