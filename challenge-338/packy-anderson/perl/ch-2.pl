#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( min max );

sub maxDistance($arr1, $arr2) {
  my ($min1, $max1) = (min(@$arr1), max(@$arr1));
  my ($min2, $max2) = (min(@$arr2), max(@$arr2));
  max(abs($max1 - $min2), abs($max2 - $min1));
}

sub solution($arr1, $arr2) {
  say 'Input: @arr1 = (' . join(', ', @$arr1) . ')';
  say '       @arr2 = (' . join(', ', @$arr2) . ')';
  say 'Output: ' . maxDistance($arr1, $arr2);
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
