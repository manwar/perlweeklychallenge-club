#!/usr/bin/env perl
use v5.44;

use List::AllUtils qw( sum );
use POSIX qw( lround );

sub divisibleAverage(@arr) {
  my @qualifying = grep { ! (($_ % 2) || ($_ % 3)) } @arr;
  return 0 unless @qualifying;
  lround(sum(@qualifying) / scalar(@qualifying));
}

sub solution($arr) {
  say 'Input: @arr = (' . join(', ', @$arr) . ')';
  say 'Output: ' . divisibleAverage(@$arr);
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
