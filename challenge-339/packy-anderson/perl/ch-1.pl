#!/usr/bin/env perl
use v5.40;

sub maxDiff(@ints) {
  my ($A, $B, $C, $D) =
    +(sort { abs($a) <=> abs($b) } @ints)[0, 1, -2, -1];
  abs(($A * $B) - ($C * $D))
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: ' . maxDiff(@$ints);
}

say "Example 1:";
solution([5, 9, 3, 4, 6]);

say "\nExample 2:";
solution([1, -2, 3, -4]);

say "\nExample 3:";
solution([-3, -1, -2, -4]);

say "\nExample 4:";
solution([10, 2, 0, 5, 1]);

say "\nExample 5:";
solution([7, 8, 9, 10, 10]);
