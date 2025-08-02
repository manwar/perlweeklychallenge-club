#!/usr/bin/env perl
use v5.40;

use Set::Scalar;
use List::AllUtils qw( min );

sub minCommon($arr1, $arr2) {
  my $set1   = Set::Scalar->new(@$arr1);
  my $set2   = Set::Scalar->new(@$arr2);
  my $common = $set1 * $set2;
  if ($common) {
    return min($common->elements);
  }
  return -1;
}

sub solution($arr1, $arr2) {
  say 'Input: @array_1 = (' . join(', ', @$arr1) . ')';
  say '       @array_2 = (' . join(', ', @$arr2) . ')';
  say 'Output: ' . minCommon($arr1, $arr2);
}

say "Example 1:";
solution([1, 2, 3, 4], [3, 4, 5, 6]);

say "\nExample 2:";
solution([1, 2, 3], [2, 4]);

say "\nExample 3:";
solution([1, 2, 3, 4], [5, 6, 7, 8]);