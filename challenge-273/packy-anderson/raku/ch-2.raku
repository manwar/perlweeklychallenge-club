#!/usr/bin/env raku
use v6;

sub bAfterA($str) {
  my $seen_b = False;
  for $str.comb -> $c {
    if ($seen_b) {
      if ($c eq 'a') {
        return False;
      }
    }
    elsif ($c eq 'b') {
      $seen_b = True;
    }
  }
  return $seen_b;
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: ' ~ bAfterA($str);
}

say "Example 1:";
solution("aabb");

say "\nExample 2:";
solution("abab");

say "\nExample 3:";
solution("aaa");

say "\nExample 4:";
solution("bbb");
