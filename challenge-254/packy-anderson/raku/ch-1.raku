#!/usr/bin/env raku
use v6;

sub isAPowerOfThree($n, $pow = 0) {
  if ($n == $pow ** 3) {
    return 'true';
  }
  elsif ($n < $pow ** 3) {
    return 'false';
  }
  return isAPowerOfThree($n, $pow + 1);
}

sub solution($n) {
  say 'Input: $n = ' ~ $n;
  say 'Output: ' ~ isAPowerOfThree($n);
}

say "Example 1:";
solution(27);

say "\nExample 2:";
solution(0);

say "\nExample 3:";
solution(6);