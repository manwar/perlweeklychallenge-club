#!/usr/bin/env raku
use v6;

sub maxDistance(@arr1, @arr2) {
  my ($min1, $max1) = (@arr1.min, @arr1.max);
  my ($min2, $max2) = (@arr2.min, @arr2.max);
  max(abs($max1 - $min2), abs($max2 - $min1));
}

sub solution(@arr1, @arr2) {
  say 'Input: @arr1 = (' ~ @arr1.join(', ') ~ ')';
  say '       @arr2 = (' ~ @arr2.join(', ') ~ ')';
  say 'Output: ' ~ maxDistance(@arr1, @arr2);
}

say "Example 1:";
solution([4, 5, 7], [9, 1, 3, 4]);

say "\nExample 2:";
solution([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]);

say "\nExample 3:";
solution([2, 1, 11, 3], [2, 5, 10, 2]);

say "\nExample 4:";
solution([1, 2, 3], [3, 2, 1]);

say "\nExample 5:";
solution([1, 0, 2, 3], [5, 0]);
