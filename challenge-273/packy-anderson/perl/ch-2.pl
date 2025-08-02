#!/usr/bin/env perl
use v5.40;

use builtin ':5.40';

sub bAfterA($str) {
  my $seen_b = false;
  foreach my $c (split //, $str) {
    if ($seen_b) {
      if ($c eq 'a') {
        return false;
      }
    }
    elsif ($c eq 'b') {
      $seen_b = true;
    }
  }
  return $seen_b;
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: ' . (bAfterA($str) ? 'True' : 'False');
}

say "Example 1:";
solution("aabb");

say "\nExample 2:";
solution("abab");

say "\nExample 3:";
solution("aaa");

say "\nExample 4:";
solution("bbb");
