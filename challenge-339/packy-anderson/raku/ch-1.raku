#!/usr/bin/env raku
use v6;

sub maxDiff(@ints is copy) {
  my ($a, $b, $c, $d) =
    @ints.sort({ abs($^a) cmp abs($^b) })[0, 1, *-2, *-1];
  abs(($a * $b) - ($c * $d))
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ maxDiff(@ints);
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
