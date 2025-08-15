#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum );

sub rangeSum($x, $y, @ints) {
  return sum @ints[$x..$y];
}

sub solution($ints, $x, $y) {
  print 'Input: @ints = (' . join(', ', @$ints) . '), ';
  say   "\$x = $x, \$y = $y";
  say 'Output: ' . rangeSum($x, $y, @$ints);
}

say "Example 1:";
solution([-2, 0, 3, -5, 2, -1], 0, 2);

say "\nExample 2:";
solution([1, -2, 3, -4, 5], 1, 3);

say "\nExample 3:";
solution([1, 0, 2, -1, 3], 3, 4);

say "\nExample 4:";
solution([-5, 4, -3, 2, -1, 0], 0, 3);

say "\nExample 5:";
solution([-1, 0, 2, -3, -2, 1], 0, 2);

