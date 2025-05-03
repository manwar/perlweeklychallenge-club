#!/usr/bin/env raku
use v6;

sub minCommon(@arr1, @arr2) {
  my $set1   = Set.new(@arr1);
  my $set2   = Set.new(@arr2);
  my $common = $set1 ∩ $set2;
  if ($common) {
    return min($common.keys);
  }
  return -1;
}

sub solution(@arr1, @arr2) {
  say 'Input: @array_1 = (' ~ @arr1.join(', ') ~ ')';
  say '       @array_2 = (' ~ @arr2.join(', ') ~ ')';
  say 'Output: ' ~ minCommon(@arr1, @arr2);
}

say "Example 1:";
solution([1, 2, 3, 4], [3, 4, 5, 6]);

say "\nExample 2:";
solution([1, 2, 3], [2, 4]);

say "\nExample 3:";
solution([1, 2, 3, 4], [5, 6, 7, 8]);
