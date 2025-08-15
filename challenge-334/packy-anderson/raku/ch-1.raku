#!/usr/bin/env raku
use v6;

sub rangeSum(@ints, $x, $y) {
  return @ints[$x..$y].sum;
}

sub solution(@ints, $x, $y) {
  print 'Input: @ints = (' ~ @ints.join(', ') ~ '), ';
  say   "\$x = $x, \$y = $y";
  say 'Output: ' ~ rangeSum(@ints, $x, $y);
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
