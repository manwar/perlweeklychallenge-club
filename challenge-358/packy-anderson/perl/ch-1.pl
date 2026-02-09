#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( max );

sub strVal($str) {
  return $str + 0 unless $str =~ /\D/;
  return length($str);
}

sub maxStrVal(@strings) {
  return max map { strVal($_) } @strings;
}

sub solution($strings) {
  say 'Input: @strings = ('
    . join(', ', map {qq{"$_"}} @$strings) . ')';
  say 'Output: ' . maxStrVal(@$strings);
}

say "Example 1:";
solution(["123", "45", "6"]);

say "\nExample 2:";
solution(["abc", "de", "fghi"]);

say "\nExample 3:";
solution(["0012", "99", "a1b2c"]);

say "\nExample 4:";
solution(["x", "10", "xyz", "007"]);

say "\nExample 5:";
solution(["hello123", "2026", "perl"]);
