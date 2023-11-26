#!/usr/bin/env raku
use v6;

sub floorSum(@arr) {
  my $sum = 0;
  for 0 .. @arr.elems - 1 -> $i {
    for 0 .. @arr.elems - 1 -> $j {
      $sum += (@arr[$i] / @arr[$j]).truncate;
    }
  }
  return $sum;
}

sub solution(*@nums) {
  say 'Input: @nums = (' ~ @nums.join(', ') ~ ')';
  my $sum = floorSum(@nums);
  say 'Output: ' ~ $sum;
}

say "Example 1:";
solution(2, 5, 9);

say "\nExample 2:";
solution(7, 7, 7, 7, 7, 7, 7);