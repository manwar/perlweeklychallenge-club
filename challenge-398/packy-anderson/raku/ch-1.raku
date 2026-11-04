#!/usr/bin/env raku
use v6;

sub divisibleAverage(@arr) {
  my @qualifying = @arr.grep({ ! (($_ mod 2) || ($_ mod 3)) });
  return 0 unless @qualifying;
  (@qualifying.sum / @qualifying.elems).round;
}

sub solution(@arr) {
  say 'Input: @arr = (' ~ @arr.join(', ') ~ ')';
  say 'Output: ' ~ divisibleAverage(@arr);
}

say "Example 1";
solution([18, 5, 7, 11]);

say "\nExample 2";
solution([6, 12, 18, 24, 30, 40]);

say "\nExample 3";
solution([3, 9, 15, 21, 27]);

say "\nExample 4";
solution([6, 12, 14, 20]);

say "\nExample 5";
solution([6, 6, 6, 12, 12]);
