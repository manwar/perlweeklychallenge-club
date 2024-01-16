#!/usr/bin/env raku
use v6;

sub smallestIndex(@ints) {
  for 0 .. @ints.end -> $i {
    return $i if ($i mod 10) == @ints[$i];
  }
  return -1;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my $smallest = smallestIndex(@ints);
  say "Output: $smallest";
}

say "Example 1:";
solution([0, 1, 2]);

say "\nExample 2:";
solution([4, 3, 2, 1]);

say "\nExample 3:";
solution([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]);