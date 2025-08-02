#!/usr/bin/env perl
use v5.40;

sub lastWord($str) {
  return length(+(split q{ }, $str)[-1]);
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: @{[lastWord($str)]}/;
}

say "Example 1:";
solution("The Weekly Challenge");

say "\nExample 2:";
solution("   Hello   World    ");

say "\nExample 3:";
solution("Let's begin the fun");
