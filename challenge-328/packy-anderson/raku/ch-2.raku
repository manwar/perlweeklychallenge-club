#!/usr/bin/env raku
use v6;

sub goodString($str is copy) {
  my $c;
  # return the unmodified string if there are no matches
  return $str
    unless $str ~~ /$<match> = ( (<lower>) {$c = $0.uc;} $c ||
                                 (<upper>) {$c = $0.lc;} $c )/;

  # replace the match with the empty string
  my $replace = $<match>;
  # when I try to use $<match> in the replacement, it doesn't work
  $str ~~ s/$replace//;

  # recursively call to eliminate additional pairs
  goodString($str);
}

sub solution($str) {
  say "Input: \$str = \"$str\"";
  say "Output: \"{goodString($str)}\"";
}

say "Example 1:";
solution("WeEeekly");

say "\nExample 2:";
solution("abBAdD");

say "\nExample 3:";
solution("abc");
